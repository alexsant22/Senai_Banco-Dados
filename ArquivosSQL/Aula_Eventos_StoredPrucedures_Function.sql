# EVENTOS
/*
- Agendar tarefas automáticas no BD;
- Backups;
- Limpeza de dados;
- Atualizações
*/

CREATE DATABASE eventos;
USE eventos;

# Ativando o evento (agendador de tarefas)
SET GLOBAL event_scheduler = ON;

# Verificando status
SHOW VARIABLES LIKE 'event_scheduler';

# Criando tabelas
CREATE TABLE logs(
    id INT AUTO_INCREMENT PRIMARY KEY,
    mensagem VARCHAR(255),
    data_hora DATETIME
);

CREATE TABLE produtos(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    preco DECIMAL(10,2),
    categoria VARCHAR(50)
);

CREATE TABLE modificacoes(
    id INT AUTO_INCREMENT PRIMARY KEY,
    mensagem VARCHAR(255),
    data_hora DATETIME
);

# Criando evento para inserir log
CREATE EVENT insere_log
    ON SCHEDULE EVERY 1 MINUTE
DO
    INSERT INTO logs(mensagem, data_hora)
    VALUES ('Execução automática', NOW());

# Verificando a tabela de logs
SELECT * FROM logs;

# Inserindo produtos
INSERT INTO produtos (nome, preco, categoria)
    VALUES ('Notebook', 5000.99, 'Eletrônicos');

INSERT INTO produtos (nome, preco, categoria)
    VALUES ('SmartPhone', 2000, 'Eletrônicos');

INSERT INTO produtos (nome, preco, categoria)
    VALUES ('Camiseta', 100, 'Vestuário');

# Criando evento para aplicar desconto nos produtos
CREATE EVENT aplica_desconto
    ON SCHEDULE EVERY 1 MINUTE
DO
    UPDATE produtos
    SET preco = preco * 0.9
    WHERE categoria = 'Eletrônicos';

# Mostrando todos os eventos
SHOW EVENTS;

# Evento para limpar logs
CREATE EVENT limpa_logs
    ON SCHEDULE EVERY 1 DAY
DO
    DELETE FROM logs
    WHERE data_hora < NOW() - INTERVAL 30 DAY;

# Ver o código do evento insere_log
SHOW CREATE EVENT insere_log;

# Remover um evento
-- DROP EVENT insere_log;

# Limpar as tabelas
TRUNCATE TABLE logs;

# Consultar produtos
SELECT id, nome, preco, categoria FROM produtos;

# Verificar quando o desconto vai ser aplicado
SELECT LAST_EXECUTED, STATUS FROM information_schema.EVENTS
    WHERE EVENT_NAME = 'insere_log';

# *******************************************************************
# STORED PROCEDURE
/* TEORIA:
- Blocos de procedimentos (reutilização)
    - Automatizo tarefas complexas!
    - Redução de repetição de código;
    - Padronizar operações no banco de dados
*/

CREATE DATABASE loja;
USE loja;
-- DROP DATABASE loja;

CREATE TABLE clientes(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    ativo BOOLEAN DEFAULT TRUE
);

CREATE TABLE vendas(
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    valor DECIMAL(10,2),
    data_venda DATE,
    FOREIGN KEY(cliente_id) REFERENCES clientes(id)
);

# Criando procedures
DELIMITER //
CREATE PROCEDURE inserir_cliente(
    IN nome_cliente VARCHAR(100),
    IN email_cliente VARCHAR(100)
)
BEGIN
    INSERT INTO clientes(nome, email) VALUES(nome_cliente, email_cliente);
END //
DELIMITER ;

# Chamando a procedure
CALL inserir_cliente('Carlos Alberto', 'Carlos@email.com');

# Calculando o total de vendas por cliente
DELIMITER //
CREATE PROCEDURE total_vendas_cliente(
    IN cliente INT,
    OUT total DECIMAL(10,2)
)
BEGIN
    SELECT SUM(valor) INTO total
    FROM vendas
    WHERE cliente_id = cliente;
END //
DELIMITER ;

# Chamando a procedure com variável de saída
SET @total_vendas = 0;
CALL total_vendas_cliente(1, @total_vendas);
SELECT @total_vendas;

# Gerenciando procedures
SHOW PROCEDURE STATUS WHERE Db = 'loja';
# Ver código da procedure
SHOW CREATE PROCEDURE inserir_cliente;
# Deletar procedure
DROP PROCEDURE inserir_cliente;

# Fazendo teste **************

SELECT * FROM clientes;
CALL inserir_cliente('Carlos Alberto', 'carlos@gmail.com');
# Pegando o id do cliente inserido
SET @cliente_id = LAST_INSERT_ID();

# Calcular o total de vendas
SET @total = 0;
CALL total_vendas_cliente(@cliente_id, @total);
SELECT @total;

CALL inserir_cliente('Cliente com vendas', 'comvendas@gmail.com');
# Pegando o id do cliente inserido
SET @cliente_id = LAST_INSERT_ID();
# Inserir vendas para o cliente
INSERT INTO vendas(cliente_id, valor, data_venda) VALUES
(@cliente_id, 100.50, '2025-03-01'),
(@cliente_id, 100.50, '2025-03-02'),
(@cliente_id, 100.50, '2025-03-03');

SELECT * FROM vendas;
# Calcular total de vendas
SET @total = 0;
CALL total_vendas_cliente(@cliente_id, @total);
SELECT @total;

# Inserir 100 clientes
DELIMITER //
CREATE PROCEDURE inserir_cliente_automatico()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 100 DO
        CALL inserir_cliente(CONCAT('Cliente', i), CONCAT('cliente', i, '@teste.com'));
        SET i = i + 1;
    END WHILE;
END //
DELIMITER ;

SELECT * FROM clientes;

# Chamando a procedure para inserir clientes automaticamente
CALL inserir_cliente_automatico();

# *****************************************************************
# FUNCTION
/* TERORIA:
 Blocos de código armazenado no BD que executa um calculo e retorna o valor correspondente
	select, where, order by etc...
    - Calculos repetitivos
    - Organização de código
*/

CREATE DATABASE funcao;
use funcao;
DELIMITER //
create function multiplica_por_dois(valor int)
	returns int
    deterministic
begin
	return valor*2;
end //
DELIMITER ;

select multiplica_por_dois(5);

# Criar tabela produtos
create table produtos(
 id int auto_increment primary key,
 nome varchar(100),
 preco decimal(10,2),
 quantidade int
);

insert into produtos (nome, preco, quantidade) values
	('notebook dell', 4200.00, 4),
    ('fone de ouvido', 199.90, 12),
    ('monitor 24 polegadas', 899.00, 0);
    
select * from produtos;

# Funçao para calcular valor total de mercadoria
DELIMITER //
create function calcular_valor_total(produto_id int)
	returns decimal(10,2)
    deterministic
begin
	declare total decimal(10,2);
    select preco * quantidade into total
    from produtos
    where id = produto_id;
    return total;
end //
DELIMITER ;

# Mostrar o valor total em estoque
select id, nome, calcular_valor_total(id) as total_em_estoque from produtos;

# Mostrar as functions criadas
show function status where Db = database();

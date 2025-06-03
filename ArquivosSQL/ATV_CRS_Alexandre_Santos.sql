 # Pesquisa sobre TCL (Transaction control language) MySQL
 /*
 TCL (Transaction Control Language) em MySQL é um conjunto de comandos usados para
 gerenciar transações dentro do banco de dados. Transações são grupos de operações que
 são executadas como uma unidade única. Elas são importantes para garantir a integridade
 dos dados, pois, se algo der errado em uma transação, você pode revertê-la para o estado
 anterior (rollback) e evitar inconsistências.
 */
 
 # *********************************************************************************************
 
 # COMMIT (O que é? Para que serve?)
 /*
 O COMMIT é um comando em SQL utilizado dentro de transações para confirmar e salvar
 permanentemente todas as alterações realizadas no banco de dados durante a transação.
	COMO FUNCIONA?
		1. Quando você começa uma transação, as alterações feitas (inserções, atualizações,
        exclusões) ficam em um estado temporário, ou seja, ainda não foram gravadas de
        forma permanente no banco de dados.
        2. O COMMIT serve para finalizar essa transação e tornar todas as alterações feitas
        definitivas, ou seja, elas são gravadas permanentemente no banco de dados. A partir
        do momento que o COMMIT é executado, todas as operações realizadas são salvas
        de forma permanente.
*/
# Exemplo COMMIT:
-- Inicia uma transação, ou seja, começa um grupo de operações que devem ser tratadas como uma única unidade.
START TRANSACTION;

-- Atualiza a quantidade de um produto no estoque, diminuindo 1 unidade do produto com ID 123.
-- Aqui, estamos supondo que o ID seja 123 e a quantidade inicial seja maior que 0.
UPDATE produtos SET quantidade = quantidade - 1 WHERE id = 123;

-- Atualiza o status do pedido para 'Enviado', referente ao pedido com ID 456.
-- Isso indica que o pedido foi processado e está pronto para ser enviado.
UPDATE pedidos SET status = 'Enviado' WHERE id = 456;

-- Se ambas as operações de atualização (no estoque e no pedido) estiverem corretas,
-- confirmamos todas as mudanças feitas até agora. Isso grava permanentemente as alterações no banco.
COMMIT;

-- Caso ocorra algum erro em qualquer uma das atualizações, você pode fazer um ROLLBACK (que reverteria todas as operações feitas até o momento):
-- ROLLBACK; -- Desfaz todas as mudanças realizadas na transação

# ********************************************************************************************************

# ROLLBACK (O que é? Para que serve?)
/*
O ROLLBACK é um comando em SQL utilizado dentro de transações para **desfazer** todas as alterações feitas
durante a transação, **retornando o banco de dados ao estado anterior** à execução da transação.
  
COMO FUNCIONA?
	1. Quando você inicia uma transação e realiza algumas operações (como inserções, atualizações ou exclusões),
	essas mudanças são feitas de forma temporária e ainda não são permanentes no banco de dados.
	2. Se algo der errado durante a execução dessas operações ou você simplesmente não quiser confirmar as mudanças,
	é possível usar o ROLLBACK para **desfazer todas as alterações** feitas desde o início da transação.
	3. O ROLLBACK **garante a integridade do banco de dados**, pois nenhuma mudança será salva se ocorrer algum erro
	durante o processo.
*/

# Exemplo de uso do ROLLBACK:

-- Inicia uma transação, ou seja, começa um grupo de operações que devem ser tratadas como uma única unidade.
START TRANSACTION;

-- Atualiza a quantidade de um produto no estoque, diminuindo 1 unidade do produto com ID 123.
-- Aqui, estamos supondo que o ID seja 123 e a quantidade inicial seja maior que 0.
UPDATE produtos SET quantidade = quantidade - 1 WHERE id = 123;

-- Atualiza o status do pedido para 'Enviado', referente ao pedido com ID 456.
-- Isso indica que o pedido foi processado e está pronto para ser enviado.
UPDATE pedidos SET status = 'Enviado' WHERE id = 456;

-- Suponhamos que durante o processo de atualização, algo deu errado,
-- como uma falha de conexão ou um erro lógico. Nesse caso, podemos desfazer tudo o que foi feito até agora
-- e retornar o banco de dados ao seu estado anterior.

ROLLBACK;

-- O ROLLBACK vai desfazer todas as mudanças feitas na transação, ou seja, as atualizações nas tabelas 'produtos' e 'pedidos'
-- não serão aplicadas e o banco de dados permanecerá no estado em que estava antes da transação.

# ********************************************************************************************************

# SAVEPOINT (O que é? Para que serve?)
/*
O SAVEPOINT é um comando em SQL utilizado dentro de transações para **marcar um ponto específico** 
dentro de uma transação, permitindo que você possa **voltar a esse ponto** se necessário, sem precisar
desfazer todas as alterações feitas na transação. É útil para realizar "checkpoints" durante o processo 
de execução de transações complexas, onde você pode querer reverter apenas parte das alterações, 
não a transação inteira.
  
COMO FUNCIONA?
	1. Quando você inicia uma transação e realiza várias operações (como inserções, atualizações ou exclusões),
	é possível criar um SAVEPOINT para marcar um ponto específico na transação.
	2. Se algo der errado após esse ponto, você pode usar o comando **ROLLBACK TO SAVEPOINT** para reverter
	para o estado marcado no SAVEPOINT, **sem perder todas as alterações feitas antes dele**.
	3. Isso pode ser útil se você quiser reverter somente uma parte das mudanças feitas até um certo ponto.
*/

# Exemplo de uso do SAVEPOINT:

-- Inicia uma transação, ou seja, começa um grupo de operações que devem ser tratadas como uma única unidade.
START TRANSACTION;

-- Atualiza a quantidade de um produto no estoque, diminuindo 1 unidade do produto com ID 123.
-- Aqui, estamos supondo que o ID seja 123 e a quantidade inicial seja maior que 0.
UPDATE produtos SET quantidade = quantidade - 1 WHERE id = 123;

-- Cria um SAVEPOINT chamado "checkpoint_1" para marcar um ponto específico na transação.
-- Caso algo dê errado após esse ponto, podemos voltar a esse estado e continuar.
SAVEPOINT checkpoint_1;

-- Atualiza o status do pedido para 'Enviado', referente ao pedido com ID 456.
-- Isso indica que o pedido foi processado e está pronto para ser enviado.
UPDATE pedidos SET status = 'Enviado' WHERE id = 456;

-- Suponha que houve um erro lógico no processo (por exemplo, o pedido com ID 456 não existe),
-- e você deseja desfazer apenas a atualização do pedido, mas manter as mudanças feitas no estoque.
-- Neste caso, podemos reverter para o "checkpoint_1", que irá desfazer somente as operações após o SAVEPOINT.
ROLLBACK TO SAVEPOINT checkpoint_1;

-- Após o ROLLBACK TO SAVEPOINT, apenas a atualização da tabela 'pedidos' será desfeita,
-- e a alteração na tabela 'produtos' (quantidade) continuará válida.
-- A transação pode seguir normalmente com mais operações ou ser finalizada com COMMIT.

-- Caso tudo tenha dado certo e não seja necessário reverter nada, você pode finalizar a transação com COMMIT:
COMMIT;

-- Se desejar remover o SAVEPOINT (caso não precise mais dele), você pode usar o RELEASE SAVEPOINT:
-- RELEASE SAVEPOINT checkpoint_1; -- Isso remove o SAVEPOINT, mas não reverte alterações.

-- Criação do banco de dados 'loja'
CREATE DATABASE IF NOT EXISTS loja_atv;

-- Seleciona o banco de dados 'loja' para usar
USE loja_atv;

-- Criação da tabela 'produtos'
CREATE TABLE IF NOT EXISTS produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,  -- ID do produto
    nome VARCHAR(255) NOT NULL,         -- Nome do produto
    quantidade INT NOT NULL CHECK (quantidade >= 0)  -- Quantidade disponível em estoque
);

-- Criação da tabela 'pedidos'
CREATE TABLE IF NOT EXISTS pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,  -- ID do pedido
    produto_id INT NOT NULL,             -- ID do produto associado ao pedido
    quantidade INT NOT NULL CHECK (quantidade > 0),  -- Quantidade do pedido
    status VARCHAR(50) DEFAULT 'Pendente',  -- Status do pedido, padrão 'Pendente'
    FOREIGN KEY (produto_id) REFERENCES produtos(id) ON DELETE CASCADE  -- Chave estrangeira
);

-- Inserir alguns produtos no estoque
INSERT INTO produtos (nome, quantidade) VALUES ('Produto A', 100);
INSERT INTO produtos (nome, quantidade) VALUES ('Produto B', 50);
INSERT INTO produtos (nome, quantidade) VALUES ('Produto C', 200);

-- Inserir alguns pedidos
INSERT INTO pedidos (produto_id, quantidade, status) VALUES (1, 2, 'Pendente');  -- Pedido de 2 unidades do Produto A
INSERT INTO pedidos (produto_id, quantidade, status) VALUES (2, 1, 'Pendente');  -- Pedido de 1 unidade do Produto B
INSERT INTO pedidos (produto_id, quantidade, status) VALUES (3, 5, 'Pendente');  -- Pedido de 5 unidades do Produto C

-- Inicia uma transação
START TRANSACTION;

-- Atualiza a quantidade do produto no estoque, diminuindo 1 unidade do produto com ID 1 (Produto A)
UPDATE produtos SET quantidade = quantidade - 1 WHERE id = 1;

-- Cria um SAVEPOINT chamado "checkpoint_1" para marcar um ponto específico na transação
SAVEPOINT checkpoint_1;

-- Atualiza o status do pedido para 'Enviado', referente ao pedido com ID 1
UPDATE pedidos SET status = 'Enviado' WHERE id = 1;

-- Suponha que houve um erro lógico e o pedido com ID 1 não pode ser enviado
-- Nesse caso, podemos reverter a atualização do pedido sem afetar o estoque.
ROLLBACK TO SAVEPOINT checkpoint_1;

-- O status do pedido com ID 1 não será alterado, mas a quantidade do produto será atualizada.

-- Vamos agora finalizar a transação com um COMMIT para salvar as alterações feitas até agora
COMMIT;

-- Remover o SAVEPOINT (caso não precise mais dele)
RELEASE SAVEPOINT checkpoint_1;

-- Verifica os produtos após a transação
SELECT * FROM produtos;

-- Verifica os pedidos após a transação
SELECT * FROM pedidos;


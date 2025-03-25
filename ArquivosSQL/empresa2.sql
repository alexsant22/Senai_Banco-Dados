# Criando Banco de Dados
CREATE DATABASE IF NOT EXISTS empresa;
-- CREATE DATABASE IF NOT EXISTS empresa2;

# Apagando Banco de Dados
-- DROP DATABASE IF EXISTS empresa2;

# Entrando no Banco de dados escolhido
use empresa;

# Criando tabela Funcionário
create table if not exists Funcionario (
	-- Atributos
	numero integer not null,
    nome varchar(100) not null,
    rua varchar(32),
    nro integer,
    bairro varchar(20),
    cidade varchar(20),
    estado varchar(20),
    cep varchar(9),
    salario float,
    numero_Supervisor integer,
    primary key(numero), -- Chave Primaria
    foreign key(numero_Supervisor) references Funcionario(numero) -- Chave Estrangeira
);

# Descrevendo tabela
desc funcionario; -- describe funcionario; # Funciona dos dois jeitos

# Criando tabela Departamento
create table if not exists Departamento (
	-- Atributos
    numero integer not null,
    nome varchar(32),
    numeroFuncGer integer,
    dataIniGer date,
    primary key(numero), -- Chave Primaria
    foreign key(numeroFuncGer) references Funcionario(numero) -- Chave Estrangeira
    on delete cascade
    on update cascade
);

alter table Funcionario add numeroDepto integer; -- Alterando tabela e adicionando atributo

alter table Funcionario add foreign key(numeroDepto) references Departamento(numero); -- Alterando tabela e adicionando chave estrangeira

desc Funcionario;

# Criando tabela Dependente
create table if not exists Dependente (
	-- Atributos
    numeroFunc integer not null,
    nome varchar(64) not null,
    dataNasc date,
    parentescpo varchar(16),
    primary key(numeroFunc, nome), -- Chave Primaria
    foreign key(numeroFunc) references Funcionario(numero) -- Chave estrangeira
);

# Criando tabela Projeto
create table if not exists Projeto (
	-- Atributos
    numero integer not null,
    nome varchar(32),
    numeroDepto integer,
    primary key(numero), -- Chave Primaria
    foreign key(numeroDepto) references Departamento(numero) -- Chave estrangeira
);

# Criando tabela LocalDep
create table if not exists LocalDep (
	-- Atributos
    numeroDepto integer not null,
    localizacao varchar(32),
    primary key(numeroDepto, localizacao), -- Chave Primaria
    foreign key(numeroDepto) references Departamento(numero) -- Chave estrangeira
);

# Criando tabela FuncionarioProjeto
create table if not exists FuncionarioProjeto (
	-- Atributos
    numeroFunc integer,
    numeroProj integer,
    horas time,
    primary key(numeroFunc, numeroProj), -- Chave Primaria
    foreign key(numeroFunc) references Funcionario(numero), -- Chave estrangeira
    foreign key(numeroProj) references Projeto(numero) -- Chave estrangeira
);

# Alterando o nome do atributo
alter table Dependente change parentescpo parentesco varchar(16); -- Muda o nome do atributo utilizando 'change'


# Inserir valores nas tabelas
# Tabela funcionario
-- insert into Funcionario (numero, nome, rua, nro, bairro, cidade, estado, cep, salario, numero_Supervisor, numerodepto)
			-- values (1, 'Carlos', 'Dos Funcionarios', 235, 'Vila Maria', 'São Carlos', 'São Paulo', '13472-200', 12525.25, 1, null);

# Visualiza tabela Funcionario
-- select * from Funcionario;

# Tabela Departamento
-- insert into Departamento (numero, nome, numeroFuncGer, dataIniGer)
			-- values (1, 'Front-End', 1, '2025-03-18');
            
# Tabela Dependente
-- insert into Dependente (numeroFunc, nome, dataNasc, parentesco)
			-- values (1, 'Snow', '2021-05-13', 'Filho');
            
# Tabela Projeto
-- insert into Projeto (numero, nome, numeroDepto)
			-- values (1, 'Roubo da Lua', 1);
            
# Tabela LocalDep
-- insert into LocalDep (numeroDepto, localizacao)
			-- values (1, 'Senai');
            
# Tabela FuncionarioProjeto
-- insert into FuncionarioProjeto (numeroFunc, numeroProj, horas)
			-- values (1, 1, '09:00:00');
            #INSERTS SCHEMA EMPRESA

# *************** INSERINDO VALORES NAS TABELAS DEPARTAMENTO **************
insert into Departamento (numero, nome, numeroFuncGer, dataIniGer)
    values (1, 'Financeiro', 1, '2010-08-20');
   
insert into Departamento (numeroFuncGer, numero, nome, dataIniGer)
    values (2, 3, 'Auditoria', '2010-08-20');
   
insert into Departamento (numero, nome, numeroFuncGer, dataIniGer)
    values (4, 'Compras', null, null);
   
insert into Departamento (numero, nome)
    values (5, 'Vendas');
   
insert into Departamento (numero, nome)
    values (6, 'Juridico');

# *************** INSERINDO VALORES NAS TABELAS FUNCIONARIO **************

insert into Funcionario(numero, nome, rua, nro, bairro, cidade, estado, cep,salario, numero_Supervisor, numeroDepto)
values (1,'João', 'Rua Bahia', 483, 'Cidade Jardim', 'Valinhos', 'SP', 23900-000, 3200.30, null, null);

insert into Funcionario (numero, nome, rua, nro, bairro, cidade, estado, cep, salario, numero_Supervisor, numeroDepto)
values (2, 'Jose', 'Rua Marechal', 27, 'Paulistano', 'Salto', 'SP', '54621-000', 1820.77, 1, 1);

insert into Funcionario (numero, nome, rua, nro, bairro, cidade, estado, cep, salario, numero_Supervisor, numeroDepto)
values (3, 'Luciano', 'Rua Teodoro', 83, 'Centro', 'Araras', 'SP', '52412-000', 1700, 2, 4);

insert into Funcionario (numero, nome, rua, nro, bairro, cidade, estado, cep, salario, numero_Supervisor, numeroDepto)
values (4, 'Danilo', 'Rua Vergueiro', 1022, 'Paraiso', 'Sao Paulo', 'SP', '13140-000', 2200.00, 1, 5);

insert into Funcionario (numero, nome, rua, nro, bairro, cidade, estado, cep, salario, numero_Supervisor, numeroDepto)
values (5, 'Patricia', 'Rua Lima', 63, 'Itaim', 'Sao Paulo', 'SP', '45123-000', 2300.00, 1, 3);

insert into Funcionario (numero, nome, rua, nro, bairro, cidade, estado, cep, salario, numero_Supervisor, numeroDepto)
values (6, 'Mariana', 'Rua Sansao', 34, 'Jacare', 'Sao Carlos', 'SP', '55981-000', 1200, 1, 5);

insert into Funcionario (numero, nome, rua, nro, bairro, cidade, estado, cep, salario, numero_Supervisor, numeroDepto)
values (7, 'Cristiano', 'Rua X', 10, 'Centro', 'Araraquara', 'SP', '14524-000', 3500.00, 2, 5);

insert into Funcionario (numero, nome, rua, nro, bairro, cidade, estado, cep, salario, numero_Supervisor, numeroDepto)
values (8, 'Fabiano', 'Rua III', 15, 'Centro', 'Sao Carlos', 'SP', '12345-000', 1950.00, 2, 1);

insert into Funcionario (numero, nome, rua, nro, bairro, cidade, estado, cep, salario, numero_Supervisor, numeroDepto)
values (9, 'Bastiao', 'Rua Sete', 19, 'Centro', 'Araraquara', 'SP', '98745-000', 6500.00, 2, 6);

insert into Funcionario (numero, nome, rua, nro, bairro, cidade, estado, cep, salario, numero_Supervisor, numeroDepto)
values (10, 'Ricardo', 'Rua 13 de Maio', 55, 'Joquei', 'Sao Paulo', 'SP', '33641-000', 2800.00, 1, 2);

# *************** INSERINDO VALORES NAS TABELAS LOCALDEP **************
#insert into LocalDep(numeroDepto, localizacao) values (1, 'Edificio Marte');

insert into localDep(numeroDepto, localizacao)
values (1, 'Edificio Marte');

insert into localDep(numeroDepto, localizacao)
values (1, 'Edificio Planeta Vermelho');

#insert into localDep(numeroDepto, localizacao)
#values (2, 'Edificio Saturno');

insert into localDep(numeroDepto, localizacao)
values (3, 'Edificio Plutao');

insert into localDep(numeroDepto, localizacao)
values (3, 'Edificio Ex-Planeta');

insert into localDep(numeroDepto, localizacao)
values (4, 'Edificio Jupiter');

insert into localDep(numeroDepto, localizacao)
values (5, 'Edificio Lua');

alter table Dependente change parentescpo parentesco varchar(16);

# *************** INSERINDO VALORES NAS TABELAS DEPENDENTE **************
insert into Dependente (numeroFunc, nome, dataNasc, parentesco)
values (5, 'Luizinho', '2010-04-02', 'Filho');

insert into Dependente (numeroFunc, nome, dataNasc, parentesco)
values (5, 'Mariazinha', '2012-06-06', 'Filha');

insert into Dependente (numeroFunc, nome, dataNasc, parentesco)
values (1, 'Julia', '2013-04-02', 'Filha');

insert into Dependente (numeroFunc, nome, dataNasc, parentesco)
values (1, 'Ana', '2006-04-03', 'Filha');

insert into Dependente (numeroFunc, nome, dataNasc, parentesco)
values (1, 'Maria', '1976-05-03', 'Esposa');

insert into Dependente (numeroFunc, nome, dataNasc, parentesco)
values (3, 'Lucas', '1998-11-28', 'Filho');

insert into Dependente (numeroFunc, nome, dataNasc, parentesco)
values (2, 'Joana', '1935-11-28', 'Mae');


# *************** INSERINDO VALORES NAS TABELAS PROJETO **************
insert into Projeto (numero, nome, numeroDepto)
values (1, 'Projeto Serra Leste', 1);

insert into Projeto (numero, nome, numeroDepto)
values (2, 'Projeto Porto Tubarao', 5);

insert into Projeto (numero, nome, numeroDepto)
values (3, 'Projeto sei la', 3);

insert into Projeto (numero, nome, numeroDepto)
values (4, 'Projeto Niquel', 1);

insert into Projeto (numero, nome, numeroDepto)
values (5, 'Projeto COVID', 3);

insert into Projeto (numero, nome, numeroDepto)
values (6, 'Projeto Lava Jato', 5);

insert into Projeto (numero, nome, numeroDepto)
values (7, 'Projeto Serra Pelada', 1);

insert into Projeto (numero, nome, numeroDepto)
values (8, 'Projeto Vale', 3);

# *************** INSERINDO VALORES NAS TABELAS FUNCIONARIOPROJETO **************
insert into FuncionarioProjeto(numeroFunc, numeroProj, horas)
values(10, 1, '10:45:00');

insert into FuncionarioProjeto (numeroFunc, numeroProj, horas)
values (1, 1, '10:45:00');

insert into FuncionarioProjeto (numeroFunc, numeroProj, horas)
values (1, 2, '09:25:00');

insert into FuncionarioProjeto (numeroFunc, numeroProj, horas)
values (1, 3, '10:15:10');

insert into FuncionarioProjeto (numeroFunc, numeroProj, horas)
values (2, 4, '20:45:15');

insert into FuncionarioProjeto (numeroFunc, numeroProj, horas)
values (2, 5, '19:45:00');

insert into FuncionarioProjeto (numeroFunc, numeroProj, horas)
values (2, 6, '16:13:00');

insert into FuncionarioProjeto (numeroFunc, numeroProj, horas)
values (2, 7, '18:00:00');

insert into FuncionarioProjeto (numeroFunc, numeroProj, horas)
values (2, 8, '08:25:00');

insert into FuncionarioProjeto (numeroFunc, numeroProj, horas)
values (7, 8, '10:25:00');

insert into FuncionarioProjeto (numeroFunc, numeroProj, horas)
values (8, 2, '11:22:03');

insert into FuncionarioProjeto (numeroFunc, numeroProj, horas)
values (10, 4, '21:55:10');
# *************** FIM INSERÇÕES **************

# drop database empresa;

# Selects
select nome from funcionario;

select nome, salario from funcionario order by salario desc; -- buscando duas colunas com o salario ordenado

select salario from funcionario;

select * from funcionario;

# inserindo funcionario
insert into Funcionario (numero, nome, rua, nro, bairro, cidade, estado, cep, salario, numero_Supervisor, numeroDepto)
values (11, 'Paulo Souza', null, null, null, null, null, null, null, null, null);

# Deletando funcionario 'Paulo Souza'
delete from funcionario where nome='Paulo Souza'; -- Da erro por conta do safe mode

# Deletando com base no salario
delete from funcionario where salario >= 10000 and salario <= 20000; -- Da erro por conta do safe mode

# Update salario dos funcionarios
update funcionario set salario = salario * 1.05; -- Da erro por conta do safe mode

update funcionario set salario = salario * 1.05 where salario <=1000; -- Da erro por conta do safe mode
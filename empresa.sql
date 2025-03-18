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

alter table Funcionario add numerodepto integer; -- Alterando tabela e adicionando atributo

alter table Funcionario add foreign key(numerodepto) references Departamento(numero); -- Alterando tabela e adicionando chave estrangeira

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
insert into Funcionario (numero, nome, rua, nro, bairro, cidade, estado, cep, salario, numero_Supervisor, numerodepto)
			values (1, 'Carlos', 'Dos Funcionarios', 235, 'Vila Maria', 'São Carlos', 'São Paulo', '13472-200', 12525.25, 1, null);

# Visualiza tabela Funcionario
select * from Funcionario;

# Tabela Departamento
insert into Departamento (numero, nome, numeroFuncGer, dataIniGer)
			values (1, 'Front-End', 1, '2025-03-18');
            
# Tabela Dependente
insert into Dependente (numeroFunc, nome, dataNasc, parentesco)
			values (1, 'Snow', '2021-05-13', 'Filho');
            
# Tabela Projeto
insert into Projeto (numero, nome, numeroDepto)
			values (1, 'Roubo da Lua', 1);
            
# Tabela LocalDep
insert into LocalDep (numeroDepto, localizacao)
			values (1, 'Senai');
            
# Tabela FuncionarioProjeto
insert into FuncionarioProjeto (numeroFunc, numeroProj, horas)
			values (1, 1, '09:00:00');
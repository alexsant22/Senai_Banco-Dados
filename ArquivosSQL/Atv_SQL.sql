
CREATE DATABASE IF NOT EXISTS empresa;
USE empresa;

-- Criando tabelas
CREATE TABLE IF NOT EXISTS Funcionario(
    numero INTEGER NOT NULL,
    nome VARCHAR(100),
    rua VARCHAR(100),
    nro INTEGER,
    bairro VARCHAR(20),
    cidade VARCHAR(20),
    estado VARCHAR(20),
    cep VARCHAR(10),
    salario FLOAT,
    numerosupervisor INTEGER,
    numero_depto INTEGER,
    PRIMARY KEY(numero),
    FOREIGN KEY(numerosupervisor) REFERENCES Funcionario(numero)
);

CREATE TABLE IF NOT EXISTS Departamento(
    numero INTEGER NOT NULL,
    nome VARCHAR(100),
    numeroFuncGer INTEGER,
    dataIniGer DATE,
    PRIMARY KEY (numero),
    FOREIGN KEY (numeroFuncGer) REFERENCES Funcionario(numero)
);

CREATE TABLE IF NOT EXISTS Dependente(
    numeroFunc INTEGER NOT NULL,
    nome VARCHAR(100) NOT NULL,
    dataNasc DATETIME,
    parentesco VARCHAR(100),
    PRIMARY KEY (numeroFunc, nome),
    FOREIGN KEY (numeroFunc) REFERENCES Funcionario(numero)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Projeto(
    numero INTEGER NOT NULL,
    nome VARCHAR(100),
    numeroDepto INTEGER,
    PRIMARY KEY (numero),
    FOREIGN KEY (numeroDepto) REFERENCES Departamento(numero)
);

CREATE TABLE IF NOT EXISTS LocalDep(
    numerodepto INTEGER NOT NULL,
    localizacao VARCHAR(100),
    PRIMARY KEY (numerodepto, localizacao),
    FOREIGN KEY (numerodepto) REFERENCES Departamento(numero)
);

CREATE TABLE IF NOT EXISTS FuncionarioProjeto(
    numerofunc INTEGER,
    numeroproj INTEGER,
    horas TIME,
    PRIMARY KEY(numerofunc, numeroproj),
    FOREIGN KEY(numerofunc) REFERENCES Funcionario(numero),
    FOREIGN KEY(numeroproj) REFERENCES Projeto(numero)
);

-- Inserções na ordem correta para respeitar as constraints de chave estrangeira

-- Primeiro inserir alguns funcionários básicos (sem supervisor e sem departamento)
INSERT INTO Funcionario(numero, nome, rua, nro, bairro, cidade, estado, cep, salario, numeroSupervisor, numero_depto)
VALUES (1, 'João', 'Rua Bahia', 483, 'Cidade Jardim', 'Valinhos', 'SP', '23900-000', 3200.30, NULL, NULL);

-- Inserir departamentos
INSERT INTO Departamento (numero, nome, numeroFuncGer, dataIniGer)
VALUES (1, 'Financeiro', NULL, NULL);

INSERT INTO Departamento (numero, nome)
VALUES (4, 'Compras');

INSERT INTO Departamento (numero, nome)
VALUES (5, 'Vendas');

INSERT INTO Departamento (numero, nome)
VALUES (6, 'Juridico');

-- Atualizar o funcionário 1 para ser gerente do departamento 1
UPDATE Funcionario SET numero_depto = 1 WHERE numero = 1;
UPDATE Departamento SET numeroFuncGer = 1, dataIniGer = '2010-08-20' WHERE numero = 1;

-- Inserir mais funcionários
INSERT INTO Funcionario (numero, nome, rua, nro, bairro, cidade, estado, cep, salario, numeroSupervisor, numero_Depto)
VALUES (2, 'Jose', 'Rua Marechal', 27, 'Paulistano', 'Salto', 'SP', '54621-000', 1820.77, 1, 1);

INSERT INTO Funcionario (numero, nome, rua, nro, bairro, cidade, estado, cep, salario, numeroSupervisor, numero_Depto)
VALUES (3, 'Luciano', 'Rua Teodoro', 83, 'Centro', 'Araras', 'SP', '52412-000', 1700, 2, 4);

INSERT INTO Funcionario (numero, nome, rua, nro, bairro, cidade, estado, cep, salario, numeroSupervisor, numero_Depto)
VALUES (4, 'Danilo', 'Rua Vergueiro', 1022, 'Paraiso', 'Sao Paulo', 'SP', '13140-000', 2200.00, 1, 5);

INSERT INTO Funcionario (numero, nome, rua, nro, bairro, cidade, estado, cep, salario, numeroSupervisor, numero_Depto)
VALUES (5, 'Patricia', 'Rua Lima', 63, 'Itaim', 'Sao Paulo', 'SP', '45123-000', 2300.00, 1, NULL);

INSERT INTO Funcionario (numero, nome, rua, nro, bairro, cidade, estado, cep, salario, numeroSupervisor, numero_Depto)
VALUES (6, 'Mariana', 'Rua Sansao', 34, 'Jacare', 'Sao Carlos', 'SP', '55981-000', 1200, 1, 5);

INSERT INTO Funcionario (numero, nome, rua, nro, bairro, cidade, estado, cep, salario, numeroSupervisor, numero_Depto)
VALUES (7, 'Cristiano', 'Rua X', 10, 'Centro', 'Araraquara', 'SP', '14524-000', 3500.00, 2, 5);

INSERT INTO Funcionario (numero, nome, rua, nro, bairro, cidade, estado, cep, salario, numeroSupervisor, numero_Depto)
VALUES (8, 'Fabiano', 'Rua III', 15, 'Centro', 'Sao Carlos', 'SP', '12345-000', 1950.00, 2, 1);

INSERT INTO Funcionario (numero, nome, rua, nro, bairro, cidade, estado, cep, salario, numeroSupervisor, numero_Depto)
VALUES (9, 'Bastiao', 'Rua Sete', 19, 'Centro', 'Araraquara', 'SP', '98745-000', 6500.00, 2, 6);

INSERT INTO Funcionario (numero, nome, rua, nro, bairro, cidade, estado, cep, salario, numeroSupervisor, numero_Depto)
VALUES (10, 'Ricardo', 'Rua 13 de Maio', 55, 'Joquei', 'Sao Paulo', 'SP', '33641-000', 2800.00, 1, NULL);

INSERT INTO Funcionario (numero, nome, rua, nro, bairro, cidade, estado, cep, salario, numeroSupervisor, numero_Depto)
VALUES (11, 'Paulo Souza', 'Rua Sete', 19, 'Centro', 'Araraquara', 'SP', '98745-000', 6500.00, 2, 6);

-- Inserir LocalDep
INSERT INTO LocalDep(numeroDepto, localizacao)
VALUES (1, 'Edificio Marte');

INSERT INTO LocalDep(numeroDepto, localizacao)
VALUES (1, 'Edificio Planeta Vermelho');

INSERT INTO LocalDep(numeroDepto, localizacao)
VALUES (6, 'Edificio Plutao');

INSERT INTO LocalDep(numeroDepto, localizacao)
VALUES (4, 'Edificio Jupiter');

INSERT INTO LocalDep(numeroDepto, localizacao)
VALUES (5, 'Edificio Lua');

-- Inserir Dependentes
INSERT INTO Dependente (numeroFunc, nome, dataNasc, parentesco)
VALUES (5, 'Luizinho', '2010-04-02', 'Filho');

INSERT INTO Dependente (numeroFunc, nome, dataNasc, parentesco)
VALUES (5, 'Mariazinha', '2012-06-06', 'Filha');

INSERT INTO Dependente (numeroFunc, nome, dataNasc, parentesco)
VALUES (1, 'Julia', '2013-04-02', 'Filha');

INSERT INTO Dependente (numeroFunc, nome, dataNasc, parentesco)
VALUES (1, 'Ana', '2006-04-03', 'Filha');

INSERT INTO Dependente (numeroFunc, nome, dataNasc, parentesco)
VALUES (1, 'Maria', '1976-05-03', 'Esposa');

INSERT INTO Dependente (numeroFunc, nome, dataNasc, parentesco)
VALUES (3, 'Lucas', '1998-11-28', 'Filho');

INSERT INTO Dependente (numeroFunc, nome, dataNasc, parentesco)
VALUES (2, 'Joana', '1935-11-28', 'Mae');

-- Inserir Projetos
INSERT INTO Projeto (numero, nome, numeroDepto)
VALUES (1, 'Projeto Serra Leste', 1);

INSERT INTO Projeto (numero, nome, numeroDepto)
VALUES (2, 'Projeto Porto Tubarao', 5);

INSERT INTO Projeto (numero, nome, numeroDepto)
VALUES (4, 'Projeto Niquel', 1);

INSERT INTO Projeto (numero, nome, numeroDepto)
VALUES (5, 'Projeto COVID', 6);

INSERT INTO Projeto (numero, nome, numeroDepto)
VALUES (6, 'Projeto Lava Jato', 5);

INSERT INTO Projeto (numero, nome, numeroDepto)
VALUES (7, 'Projeto Serra Pelada', 1);

-- Inserir FuncionarioProjeto
INSERT INTO FuncionarioProjeto (numeroFunc, numeroProj, horas)
VALUES (1, 1, '10:45:00');

INSERT INTO FuncionarioProjeto (numeroFunc, numeroProj, horas)
VALUES (1, 2, '09:25:00');

INSERT INTO FuncionarioProjeto (numeroFunc, numeroProj, horas)
VALUES (2, 4, '20:45:15');

INSERT INTO FuncionarioProjeto (numeroFunc, numeroProj, horas)
VALUES (2, 5, '19:45:00');

INSERT INTO FuncionarioProjeto (numeroFunc, numeroProj, horas)
VALUES (2, 6, '16:13:00');

INSERT INTO FuncionarioProjeto (numeroFunc, numeroProj, horas)
VALUES (2, 7, '18:00:00');

INSERT INTO FuncionarioProjeto (numeroFunc, numeroProj, horas)
VALUES (8, 2, '11:22:03');

# Fim dos inserts

#Select material de aula
SELECT nome From funcionario;
select salario from funcionario;
select *from funcionario;

delete from funcionario where nome="Paulo Souza";

update funcionario set salario = salario * 1.05 where salario <= 1000;

select nome, cidade, salario/1000 from funcionario;

###ATIVIDADE###
#1.Liste todos os dados de todos os funcionarios da empresa.
select * from funcionario;

#2.Liste os estados de origem dos funcionarios da empresa.
select funcionario.estado from funcionario;

#3.Liste os valores distintos de salario pagos aos funcionarios.
select distinct funcionario.salario from funcionario;

#4
select funcionario.nome from funcionario where nome like '%R%';

#5
select F.nome, F.numero from Funcionario F, Departamento d
where d.numeroFuncGer = F.numero;
    
#6
select F.numero, F.nome, F.salario, d.dataIniGer from Funcionario F, Departamento d 
where d.numeroFuncGer = f.numero and 
salario > 2000 and 
TIMESTAMPDIFF(year,dataIniGer,current_date()) > 3;

#7
select * from funcionario F where F.salario = (select max(salario) from Funcionario);

#8
select p.nome, sum(horas) from projeto p, FuncionarioProjeto fp 
where fp.numeroproj = 2 and  fp.numeroproj = p.numero;

#9
select avg(horas) from funcionarioProjeto fp, projeto p where fp.numeroproj = 3 and fp.numeroproj = p.numero;

#10
 select D.nome, TIMESTAMPDIFF(year,dataNasc,current_date()) as idade from Dependente d;
 
#11
select numero, nome, salario from funcionario
where cidade = 'Sao Paulo' and salario > 2200;

#12
select f.nome, dep.nome as dependentes from funcionario f, dependente dep 
where f.numero = dep.numerofunc;

#13
select f.nome, fp.numeroProj from funcionario f, funcionarioProjeto fp where f.numero = fp.numeroFunc;

#14
select * from funcionarioProjeto fp, funcionario f where fp.numeroFunc = f.numero and fp.horas > '20:00:00';
select f.nome, fp.numeroProj from funcionarioProjeto fp, funcionario f where fp.numeroFunc = f.numero and fp.horas > '20:00:00';

#15
SELECT * FROM funcionario ORDER BY nome desc;
SELECT * FROM funcionario ORDER BY nome asc;

#16
SELECT * FROM funcionario ORDER BY cidade asc;
SELECT * FROM funcionario ORDER BY salario desc;

#17
select nome, salario from funcionario where salario >= 1000 and salario <= 2000;

#18
select cidade from Funcionario where cidade like '%ar%';

#19
select max(salario) as 'Maior_salario' from funcionario;

#20
select min(salario) as 'Menor_salario' from funcionario;

#21
select ROUND(avg(salario),2) as 'Media_salario' from funcionario;

#22
select round(sum(salario), 0) from funcionario;

#23
select count(*) as 'Pessoas_Salario_Maior_1500'from funcionario where salario > 1500;

#24
select * from funcionario where cidade like '%São%';
 
#25
select count(salario) as 'Qtd_Pessoas_Recebe_>_MediaSalarial' from funcionario where salario > (select avg(salario) from funcionario);

#26
select nome from funcionario where funcionario.numeroSupervisor is null;

#27
select nome from funcionario where funcionario.numeroSupervisor is not null;

#28
select f1.nome as 'Funcionario', f2.nome'Supervisor' from Funcionario f1, Funcionario f2 where f2.numero = f1.numerosupervisor;

#29
select f.nome, fp.horas from funcionario f, funcionarioprojeto fp where f.numero = fp.numerofunc and horas = (select max(horas) from funcionarioprojeto);

#30
select f.nome from funcionario f, funcionarioprojeto fp where f.numero = fp.numerofunc;

select nome from funcionario where numero in (select numerofunc from funcionarioprojeto);
-- Desafio quais projetos eles trabalham
select f.nome, p.nome as "projeto" from funcionario f, funcionarioprojeto fp, projeto p where f.numero = fp.numerofunc and fp.numeroproj = p.numero;

#31
select nome from funcionario where numero not in (select numerofunc from funcionarioprojeto);

#32
select f.nome, fp.horas from funcionario f, funcionarioprojeto fp where f.numero = fp.numerofunc and fp.horas = (select horas from funcionarioprojeto where numeroproj = 1);

-- **** JOINS ****
# Exemplos material de aula
# Slide 8
Select nome, horas From (funcionario f join funcionarioprojeto p on f.numero = p.numerofunc) where horas in ('9:00:00', '18:00:00');

# Slide 11
Select nome, numeroproj, horas From (funcionario f inner join funcionarioprojeto p on f.numero = p.numerofunc);

# Slide 13
select nome, numeroproj from (funcionario f left outer join funcionarioprojeto p on f.numero = p.numerofunc);

# Slide 15
select numerofunc, f.nome, numeroproj, p.nome 
	from (funcionario f right outer join funcionarioprojeto fp on f.numero = fp.numerofunc) 
		right outer join projeto p on fp.numeroproj = p.numero;

# Slide 17
select F.numero AS FuncionarioNumero, F.nome AS FuncionarioNome, P.numero AS ProjetoNumero, P.nome AS Projetonome 
	FROM funcionario F
		LEFT OUTER JOIN FuncionarioProjeto FP ON F.numero = FP.numerofunc
		LEFT OUTER JOIN Projeto P ON FP.numeroproj = P.numero
UNION
	select F.numero AS FuncionarioNumero, F.nome AS FuncionarioNome, P.numero AS ProjetoNumero, P.nome AS ProjetoNome 
		FROM funcionario F
			LEFT OUTER JOIN FuncionarioProjeto FP ON F.numero = FP.numerofunc
			LEFT OUTER JOIN Projeto P ON FP.numeroproj = P.numero;

# Sliede 19
select F.numero, F.nome, P.numero, P.nome
	from (funcionario F left outer join funcionarioprojeto FP on
		F.numero = FP.numerofunc) left outer join projeto P on
        FP.numeroproj = P.numero where FP.numeroproj is null;
        
# Slide 21
select f.numero, f.nome, p.numero, p.nome from (funcionario f left outer join
	funcionarioprojeto fp on f.numero = fp.numerofunc) left outer join projeto p on
		fp.numeroproj= p.numero where fp.numeroproj is NULL
	union
select f.numero, f.nome, p.numero, p.nome from (funcionario f right  join
	funcionarioprojeto fp on f.numero = fp.numerofunc) right outer join projeto p on
		fp.numeroproj= p.numero where fp.numeroproj is NULL;
        
# Slide 23
select D.numero, D.nome, avg(salario) as media 
	From departamento D, funcionario f 
		where D.numero=f.numero_depto
			group by f.numero_depto;

# Slide 26
select numerofunc, sec_to_time(sum(time_to_sec(horas))) as total
	from funcionarioprojeto
		group by numerofunc;
        
# Slide 27
select * from
	(select numerofunc, sec_to_time(sum(time_to_sec(horas))) as total
		from funcionarioprojeto group by numerofunc) as X
			inner join funcionario as F on X.numerofunc = F.numero and
				X.total = (select max(total) from
					(select numero func , sec_to_time(sum(time_to_sec(horas))) as total
						from funcionarioprojeto group by numerofunc) B);
                        
# Slide 29
select D.numero, D.nome, avg(salario) as media
	from departamento D, funcionario F
		where D.numero = F.numero_depto
			group by F.numero_depto
				having media > 2300.00;

# **** Atividades ****
# 1)
select p.numero, p.nome, f.nome
	from projeto p join funcionarioprojeto fp on 
		p.numero = fp.numeroproj join funcionario f on f.numero = fp.numerofunc;
        
# 2)
select p.numero, p.nome, f.nome
	from projeto p left join funcionarioprojeto fp on 
		p.numero = fp.numeroproj left join funcionario f on f.numero = fp.numerofunc;
        
# 3)
select round(avg(salario),2) as 'Media Salarial'
	from funcionario;
    
# 4)
select d.numero, d.nome, avg(salario) as 'Media'
	from departamento d join funcionario f on
		f.numero_depto = d.numero
			group by d.numero;

# 5)
select d.numero, d.nome, count(salario) as 'nro funcionario',
	round(avg(f.salario),2) as 'Media' from departamento d
		join funcionario f on f.numero_depto = d.numero
			group by d.numero;
            
# 6)
select d.numero, d.nome, count(salario) as 'nro funcionario',
	round(avg(f.salario),2) as 'Media' from departamento d
		left join funcionario f on f.numero_depto = d.numero
			group by d.numero;
            
# 7)
select d.numero, d.nome, count(salario) as 'nro_funcionario',
	round(avg(f.salario),2) as 'Media' from departamento d
		left join funcionario f on f.numero_depto = d.numero
			group by d.numero
				having nro_funcionario > 2;

# 8)
select f1.nome as 'gerente', d.nome, f2.nome as 'subordinado'
	from funcionario f1 join departamento d
		on f1.numero = d.numerofuncger
			join funcionario f2 on f2.numero_depto = d.numero;

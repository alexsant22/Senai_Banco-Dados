
DROP DATABASE IF EXISTS futebol_aula;
CREATE DATABASE IF NOT EXISTS futebol_aula ;
USE futebol_aula;
-- show databases;
-- describe ou desc funcionario;
-- show tables


-- Inicio da Execucao com usuario futebol
-- Remover tabelas do banco (ordem importa)
/*
DROP TABLE Jogo;
DROP TABLE EquipeCampeonato;
DROP TABLE JogadorBrasileiro;
DROP TABLE JogadorEstrangeiro;
DROP TABLE Cidade;
DROP TABLE PaisesTecnicos;
DROP TABLE Tecnico;
DROP TABLE Campeonato;
DROP TABLE Equipe;
ALTER TABLE SeqEquipe AUTO_INCREMENT = 1;
ALTER TABLE SeqCampeonato AUTO_INCREMENT = 1;
*/
CREATE TABLE Equipe (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(32)
);

INSERT INTO Equipe (id, nome) VALUES (1, 'Palmeiras');
INSERT INTO Equipe (id, nome) VALUES (2, 'Santos');
INSERT INTO Equipe (id, nome) VALUES (3, 'SCCP');
INSERT INTO Equipe (id, nome) VALUES (4, 'SPFC');

CREATE TABLE Campeonato (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(32)
);

INSERT INTO Campeonato (id, nome) VALUES (1, 'Campeonato Brasileiro');
INSERT INTO Campeonato (id, nome) VALUES (2, 'Copa do Brasil');

CREATE TABLE JogadorBrasileiro (
  id INT AUTO_INCREMENT PRIMARY KEY,
  cpf VARCHAR(16) UNIQUE,
  nome VARCHAR(32),
  posicao VARCHAR(16),
  idEquipe INT,
  salario INT(9),
  CONSTRAINT fk_jogadorbrasileiro_idEquipe FOREIGN KEY(idEquipe)
    REFERENCES Equipe(id),
  CONSTRAINT ck_jogadorbrasileiro_posicao CHECK (posicao IN ('Goleiro', 'Lateral', 'Zagueiro', 'Meio-Campo', 'Atacante'))
);


INSERT INTO JogadorBrasileiro (cpf, nome, posicao, idEquipe, salario) 
  VALUES ('111.222.333.44', 'Sao Marcos', 'Goleiro', 1, 350000.75);
  select * from jogadorbrasileiro;
INSERT INTO JogadorBrasileiro (cpf, nome, posicao, idEquipe, salario) 
  VALUES ('098.765.345.12', 'Neymar', 'Atacante', 2, 565000.50);
INSERT INTO JogadorBrasileiro (cpf, nome, posicao, idEquipe, salario) 
  VALUES ('045.456.555.12', 'Betao', 'Zagueiro', 3, 18000.00);
INSERT INTO JogadorBrasileiro (cpf, nome, posicao, idEquipe, salario) 
  VALUES ('235.457.789-65', 'Alex', 'Meio-Campo', 1, 310000.20);
INSERT INTO JogadorBrasileiro (cpf, nome, posicao, idEquipe, salario) 
  VALUES ('777.854.123-68', 'Ronaldinho', 'Atacante', 2, 425000.00);
INSERT INTO JogadorBrasileiro (cpf, nome, posicao, idEquipe, salario) 
  VALUES ('159.487.236-00', 'Gilmar Fuba', 'Atacante', 3, 8500.00);
INSERT INTO JogadorBrasileiro (cpf, nome, posicao, idEquipe, salario) 
  VALUES ('457.148.230-00', 'Iranildo', 'Meio-Campo', null, 0);
INSERT INTO JogadorBrasileiro (cpf, nome, posicao, idEquipe, salario) 
  VALUES ('476.555.788-15', 'Odvan', 'Zagueiro', null, 0);



CREATE TABLE JogadorEstrangeiro (
  id INT AUTO_INCREMENT PRIMARY KEY,
  passaporte VARCHAR(16) UNIQUE,
  nome VARCHAR(32),
  posicao VARCHAR(16),
  idEquipe INT,
  paisOrigem VARCHAR(16),
  salario INT(9),
  CONSTRAINT fk_jogadorestrangeiro_idEquipe FOREIGN KEY(idEquipe)
    REFERENCES Equipe(id)
);

INSERT INTO JogadorEstrangeiro (passaporte, nome, posicao, idEquipe, paisOrigem, salario) 
  VALUES ('586.324.111.44', 'Arce', 'Lateral', 1, 'Paraguai', 200500.10);
INSERT INTO JogadorEstrangeiro (passaporte, nome, posicao, idEquipe, paisOrigem, salario) 
  VALUES ('348.562.363.14', 'Mancuso', 'Atacante', 3, 'Argentina', 110000.75);
INSERT INTO JogadorEstrangeiro (passaporte, nome, posicao, idEquipe, paisOrigem, salario) 
  VALUES ('456.357.698.47', 'Gioino', 'Atacante', 3, 'Argentina', 15000);


CREATE TABLE EquipeCampeonato (
  idEquipe INT,
  idCampeonato INT,
  posicao INT,
  PRIMARY KEY (idEquipe, idCampeonato),
  CONSTRAINT fk_equipecampeonato_idEquipe FOREIGN KEY (idEquipe)
    REFERENCES Equipe(id),
  CONSTRAINT fk_equipecampeonato_idCamp FOREIGN KEY (idCampeonato)
    REFERENCES Campeonato(id),
  CONSTRAINT ck_equipecampeonato_posicao CHECK (posicao > 0)
);

INSERT INTO EquipeCampeonato (idEquipe, idCampeonato, posicao)
  VALUES (1, 1, 1);
INSERT INTO EquipeCampeonato (idEquipe, idCampeonato, posicao)
  VALUES (2, 1, 16);
INSERT INTO EquipeCampeonato (idEquipe, idCampeonato, posicao)
  VALUES (3, 1, 3);
INSERT INTO EquipeCampeonato (idEquipe, idCampeonato, posicao)
  VALUES (4, 1, 8);

CREATE TABLE Cidade (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(32),
  estado VARCHAR(2)
);

INSERT INTO Cidade (id, nome, estado) VALUES (1, 'Sao Paulo', 'SP');
INSERT INTO Cidade (id, nome, estado) VALUES (2, 'Rio de Janeiro', 'RJ');
INSERT INTO Cidade (id, nome) VALUES ( 3, 'Belo Horizonte');
INSERT INTO Cidade (id, nome) VALUES (4, 'Porto Alegre');
INSERT INTO Cidade (id, nome) VALUES (5, 'Recife');

CREATE TABLE Tecnico (
  id INT AUTO_INCREMENT PRIMARY KEY,
  cpf VARCHAR(16) UNIQUE,
  nome VARCHAR(32),
  idEquipe INT,
  dataNasc DATE,
  CONSTRAINT fk_tecnico_idEquipe FOREIGN KEY(idEquipe)
    REFERENCES Equipe(id)
);

INSERT INTO Tecnico (id, cpf, nome, idEquipe, dataNasc) 
  VALUES (1, '123.654.875-90', 'Marcelo de Oliveira', 1, '1965-03-04');
INSERT INTO Tecnico (id, cpf, nome, idEquipe, dataNasc) 
  VALUES (2, '565.187.765-12', 'Dorival Junior', 2, '1962-04-25');
INSERT INTO Tecnico (id, cpf, nome, idEquipe, dataNasc) 
  VALUES (3, '098.904.642-65', 'Tite', 3, '1961-05-25');
INSERT INTO Tecnico (id, cpf, nome, idEquipe, dataNasc) 
  VALUES (4, '187.644.235-20', 'Osorio', 4, '1962-06-08');

CREATE TABLE PaisesTecnicos (
  idTecnico INT,
  pais VARCHAR(32),
  PRIMARY KEY (idTecnico, pais),
  FOREIGN KEY (idTecnico)
    REFERENCES Tecnico(id)
    ON DELETE CASCADE
);

INSERT INTO PaisesTecnicos (idTecnico, pais) VALUES (1, 'Brasil');
INSERT INTO PaisesTecnicos (idTecnico, pais) VALUES (2, 'Brasil');
INSERT INTO PaisesTecnicos (idTecnico, pais) VALUES (3, 'Brasil');
INSERT INTO PaisesTecnicos (idTecnico, pais) VALUES (3, 'Emirados Arabes');
INSERT INTO PaisesTecnicos (idTecnico, pais) VALUES (4, 'Estados Unidos');
INSERT INTO PaisesTecnicos (idTecnico, pais) VALUES (4, 'Colombia');
INSERT INTO PaisesTecnicos (idTecnico, pais) VALUES (4, 'Mexico');
INSERT INTO PaisesTecnicos (idTecnico, pais) VALUES (4, 'Brasil');

CREATE TABLE Jogo (
  id INT AUTO_INCREMENT PRIMARY KEY,
  dataJogo DATE,
  idEquipeCasa INT,
  idEquipeFora INT,
  golsEquipeCasa INT,
  golsEquipeFora INT,
  idCidade INT,
  estadio VARCHAR(32),
  idCampeonato INT,
  FOREIGN KEY (idEquipeCasa)
    REFERENCES Equipe (id),
  FOREIGN KEY (idEquipeFora)
    REFERENCES Equipe (id),
  FOREIGN KEY (idCidade)
    REFERENCES Cidade (id)
    ON DELETE SET NULL,
  FOREIGN KEY (idCampeonato)
    REFERENCES Campeonato (id)
);

INSERT INTO Jogo (id, dataJogo, idEquipeCasa, idEquipeFora, 
                golsEquipeCasa, golsEquipeFora, idCidade, estadio, idCampeonato)
  VALUES (1, '2015-06-10', 3, 1, 0, 2, 1, 'Itaquerao', 1);
INSERT INTO Jogo (id, dataJogo, idEquipeCasa, idEquipeFora, 
                golsEquipeCasa, golsEquipeFora, idCidade, estadio, idCampeonato)
  VALUES (2, '2015-06-11', 2, 4, 2, 2, 1, 'Vila Belmiro', 1);
INSERT INTO Jogo (id, dataJogo, idEquipeCasa, idEquipeFora, 
                golsEquipeCasa, golsEquipeFora, idCidade, estadio, idCampeonato)
  VALUES (3, '2015-06-11', 2, 3, 3, 2, NULL, 'Morumbi', 1);


INSERT INTO equipe (nome) VALUES ('Flamengo');
INSERT INTO equipe (nome) VALUES ('Fluminense');
INSERT INTO equipe (nome) VALUES ('Vasco');
INSERT INTO equipe (nome) VALUES ('Gremio');
INSERT INTO equipe (nome) VALUES ('Internacional');
INSERT INTO equipe (nome) VALUES ('Atletico PR');
INSERT INTO equipe (nome) VALUES ('Coritiba');
INSERT INTO equipe (nome) VALUES ('Atletico MG');
INSERT INTO equipe (nome) VALUES ('Cruzeiro');
INSERT INTO equipe (nome) VALUES ('Bahia');
INSERT INTO equipe (nome) VALUES ('Vitoria');
INSERT INTO equipe (nome) VALUES ('Sport');
INSERT INTO equipe (nome) VALUES ('Nautico');
INSERT INTO equipe (nome) VALUES ('Ponte Preta');
INSERT INTO equipe (nome) VALUES ('Guarani');
INSERT INTO equipe (nome) VALUES ('Portuguesa');

select * from equipe;


###############################################
# **** VIWES ****

#1
create or replace view ListaAtacantesBrasileiros as 
	select * from JogadorBrasileiro
		where posicao like 'Atacante';
        
select * from ListaAtacantesBrasileiros;

select nome, cpf, salario from ListaAtacantesBrasileiros where salario > 200000;

desc ListaAtacantesBrasileiros;

insert into ListaAtacantesBrasileiros (cpf, nome, posicao, idEquipe, salario)
	values ('987.654.345-89', 'Pato', 'Atacante', 4, 400000);

-- ---------------------------------------------------------------------------------

insert into ListaAtacantesBrasileiros (cpf, nome, posicao, idEquipe, salario)
	values ('134.567.356-23', 'Breno', 'Zagueiro', 4, 17000);
    
create or replace view ListaAtacantesBrasileiros as 
	select * from JogadorBrasileiro
		where posicao like 'Atacante'
			with check option;
            
insert into ListaAtacantesBrasileiros (cpf, nome, posicao, idEquipe, salario)
	values ('171.156.123-21', 'Gil', 'Zagueiro', 3, 150000);
    
-- ----------------------------------------------------------------------------------

alter view ListaAtacantesBrasileiros as
	select nome, posicao from JogadorBrasileiro
		where posicao = 'Atacante';
        
#drop view if exists ListaAtacantesBrasileiros;

create table ListaAtacantesBrasileiros as
	select * from JogadorBrasileiro
		where posicao like 'Atacante';
        
truncate table ListaAtacantesBrasileiros; -- limpa a tabela INTEIRA

insert into ListaAtacantesBrasileiros
	select * from JogadorBrasileiro
		where posicao like 'Atacante'; -- reinicia os dados da tabela INTEIRA
        
#5
create event AtualizarListaAtacantes
	on schedule every 1 day do
	
			truncate table ListaAtacantesBrasileiros;

			insert into ListaAtacantesBrasileiros
				select * from JogadorBrasileiro
					where posicao like 'Atacante';
		

#2
create or replace view Jogadores as
	select nome, posicao, idEquipe, paisOrigem, salario
		from JogadorEstrangeiro
	union
    select nome, posicao, idEquipe, 'Brasil', salario
		from JogadorBrasileiro;
        
select * from Jogadores;

desc Jogadores;

#3
create or replace view MediaPorPosicao (
	posicao, mediaSalario) as
		select j.posicao, avg(j.salario)
			from jogadores j group by j.posicao;
            
select * from MediaPorPosicao;

desc MediaPorPosicao;

#4
create or replace view EquipesJogadores as 
	select e.nome as equipe, j.nome as jogador
		from jogadores j join equipe e
			on e.id = j.idEquipe;
            
select * from EquipesJogadores;

desc EquipesJogadores;

# ***********************
# ********* INDICES *****
# ***********************

create table TORCEDOR(
 id int,
 nome varchar(30),
 sexo char(1),
 idEquipe int,
 constraint pk_torcedor primary key(id),
 constraint fk_torcedor_equipe foreign key(idEquipe)
 references Equipe(id)
 );

create table TORCEDOR2(
 id int,
 nome varchar(30),
 sexo char(1),
 idEquipe int,
 constraint pk_torcedor2 primary key(id),
 constraint fk_torcedor_equipe2 foreign key(idEquipe)
 references Equipe(id)
 );

EXPLAIN select * from torcedor where id = 5;

DELIMITER $$

CREATE PROCEDURE popular_torcedores()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 100000 DO
        INSERT INTO torcedor(id, nome)
        VALUES(i, CONCAT('torcedor', LPAD(i, 6, '0')));
        INSERT INTO torcedor2(id, nome)
        VALUES(i, CONCAT('torcedor2', LPAD(i, 6, '0')));
        IF MOD(i, 10000) = 0 THEN
            COMMIT;
        END IF;
        SET i = i + 1;
    END WHILE;
    COMMIT;
END $$

DELIMITER ;

SELECT * FROM torcedor;
-- contar o tempo de execução
-- Ativar profiling
SET PROFILING = 1;

-- Consulta de exemplo
SELECT * FROM torcedor WHERE nome = 'Torcedor000123';

-- Execute a procedure SEPARADAMENTE para evitar erro de "out of sync"
CALL popular_torcedores();

-- Depois, consulte os tempos
SHOW PROFILES;

-- Atualizar sexos
UPDATE Torcedor SET sexo = 'M' WHERE MOD(id, 2) = 0;
UPDATE Torcedor SET sexo = 'F' WHERE MOD(id, 2) = 1;
UPDATE Torcedor2 SET sexo = 'M' WHERE MOD(id, 2) = 0;
UPDATE Torcedor2 SET sexo = 'F' WHERE MOD(id, 2) = 1;

-- Corrigir a variável 'i' -> usar 'id'
UPDATE Torcedor SET idEquipe = MOD(id, 10) + 1;
UPDATE Torcedor2 SET idEquipe = MOD(id, 10) + 1;

-- Somente depois, se quiser, remova a procedure
DROP PROCEDURE IF EXISTS popular_torcedores;
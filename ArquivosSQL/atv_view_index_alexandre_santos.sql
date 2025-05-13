# ATIVIDADE 13/05/2025  VIEW e INDEX

DROP DATABASE IF EXISTS atv_view_index_alexandre_santos;
CREATE DATABASE IF NOT EXISTS atv_view_index_alexandre_santos;
USE atv_view_index_alexandre_santos;


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
INSERT INTO Campeonato (id, nome) VALUES (3, 'Libertadores');

CREATE TABLE JogadorBrasileiro (
  id INT AUTO_INCREMENT PRIMARY KEY,
  cpf VARCHAR(16) UNIQUE,
  nome VARCHAR(32),
  posicao VARCHAR(16),
  idEquipe INT,
  salario INT,
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


-- drop TABLE JogadorEstrangeiro; 
CREATE TABLE JogadorEstrangeiro (
  id INT AUTO_INCREMENT PRIMARY KEY,
  passaporte VARCHAR(16) UNIQUE,
  nome VARCHAR(32),
  posicao VARCHAR(16),
  idEquipe INT,
  paisOrigem VARCHAR(16),
  salario INT,
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
  VALUES (1, 3, 1);
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


-- Lista atacantes brasileiros
SELECT * FROM JogadorBrasileiro
  WHERE posicao like 'Atacante';

-- Visão que lista as informações dos atacantes brasileiros  
CREATE OR REPLACE VIEW ListaAtacantesBrasileiros AS
  SELECT * FROM JogadorBrasileiro
    WHERE posicao like 'Atacante';
    
-- Seleciona visão criada
SELECT * FROM ListaAtacantesBrasileiros;

-- Seleciona atacantes brasileiros que ganham mais que 200000 (SLIDE 12)
SELECT nome, cpf FROM ListaAtacantesBrasileiros
  WHERE salario > 200000;

-- Descreve visão
DESC ListaAtacantesBrasileiros;

-- Lista todos os jogadores (brasileiros e estrangeiros) (SLIDE 13)
SELECT nome, posicao, idEquipe, paisOrigem, salario 
  FROM JogadorEstrangeiro
UNION
SELECT nome, posicao, idEquipe, 'Brasil', salario 
  FROM JogadorBrasileiro;

-- Criação de visão para listagem das médias por posicao (SLIDE 14)
CREATE OR REPLACE VIEW MediaPorPosicao (posicao, mediaSalario) AS
  SELECT j.posicao, AVG(j.salario) FROM JogadorBrasileiro j
    GROUP BY j.posicao;

-- Criação da visão com os nomes de equipes e jogadores (SLIDE 15)
CREATE OR REPLACE VIEW EquipesJogadores AS  
  SELECT e.nome AS equipe, j.nome AS jogador
    FROM JogadorBrasileiro j JOIN Equipe e
    ON e.id = j.idEquipe;

SELECT * FROM EquipesJogadores;
DESC EquipesJogadores;

-- Inserção por meio de visões (SLIDE 17)
INSERT INTO ListaAtacantesBrasileiros (cpf, nome, posicao, idEquipe, salario)
  VALUES ('987.654.345-89', 'Dodo', 'Atacante', 4, 400000);

#---------------------------------------------------------------------------------------------------
-- Adicionando clausula WITH CHECK OPTION   (SLIDE 18)
CREATE OR REPLACE VIEW ListaAtacantesBrasileiros AS
  SELECT * FROM JogadorBrasileiro
    WHERE posicao like 'Atacante'
    WITH CHECK OPTION;

-- Inserção não funciona, pois jogador a ser inserido não é Atacante  
INSERT INTO ListaAtacantesBrasileiros (cpf, nome, posicao, idEquipe, salario)
  VALUES ('171.156.123-21', 'Murilo', 'Zagueiro', 3, 150000);


#*****************************************
#************* QUESTÕES *****************
#*****************************************

#PARTE 1(SELECTS E JOINS)
-- a) Listar todos os jogadores brasileiros e seus clubes
select br.nome as Jogadores, e.nome as Equipes
	from jogadorbrasileiro br join equipe e
    on br.idequipe = e.id;

-- b) Listar técnicos que trabalharam no Brasil
select t.nome as Tecnicos, p.pais as Pais
	from tecnico t join paisestecnicos p
    on t.id = p.idTecnico
    where pais like 'Brasil';

-- c) Jogadores (brasileiros e estrangeiros) com salário maior que 300 mil
select br.nome as Jogadores, br.salario as Salario
	from jogadorbrasileiro br where salario > 300000
    union
select je.nome as Jogadores, je.salario as Salario
	from jogadorestrangeiro je where salario > 300000;

-- d) Equipes e suas posições no Campeonato Brasileiro
select c.nome as Capeonato, e.nome as Equipes, ec.posicao as Posicao
	from equipe e 
    join equipecampeonato ec on e.id = ec.idequipe
    join campeonato c on c.id = ec.idCampeonato
    where idCampeonato = 1;
    -- where nome = 'Campeonato Brasileiro'; # Não funfa

-- e) Jogos com placar e cidade
select ec.nome as Equipe_Casa, j.golsEquipeCasa as Gols_EC, j.golsEquipeFora as Gols_EF, ef.nome as Equipe_Fora, c.nome as Cidade
	from jogo j
	join equipe ec on j.idEquipeCasa = ec.id
	join equipe ef on j.idEquipeFora = ef.id
	join cidade c on j.idCidade = c.id;


#PARTE 2(VIEWS)
# Crie visões (views) que tragam informações relevantes e organizadas sobre o banco de dados
# para facilitar análises e relatórios.
# Instruções:
# - Defina os campos corretamente com os tipos de dados apropriados;
# - Utilize chaves estrangeiras quando necessário;
# - Garanta a integridade referencial;
# - As views devem trazer dados de forma clara e útil, com pelo menos um JOIN entre tabelas.

-- a) View_Jogadores_Equipes
# Mostra todos os jogadores brasileiros com o nome de sua equipe.
create or replace view JogadoresBR_Equipes as
	select br.nome as Jogadores, e.nome as Equipes
		from jogadorbrasileiro br join equipe e
		on br.idequipe = e.id;

select * from JogadoresBR_Equipes;

-- b) View_Tecnicos_Experiencia
# Mostra os técnicos e os países onde já trabalharam.
create or replace view View_Tecnicos_Experiencia as
	select t.nome as Tecnicos, p.pais as Pais
		from tecnico t join paisestecnicos p
		on t.id = p.idTecnico;
        
select * from View_Tecnicos_Experiencia;

-- c) View_Resultados_Jogos
# Mostra o resultado dos jogos com nomes das equipes e cidade.
create or replace view View_Resultados_Jogos as
	select ec.nome as Equipe_Casa, j.golsEquipeCasa as Gols_EC, j.golsEquipeFora as Gols_EF, ef.nome as Equipe_Fora, c.nome as Cidade
		from jogo j
		join equipe ec on j.idEquipeCasa = ec.id
		join equipe ef on j.idEquipeFora = ef.id
		join cidade c on j.idCidade = c.id;
        
select * from View_Resultados_Jogos;

-- d) View_Salario_Medio_Equipe
# Mostra o salário médio dos jogadores de cada equipe.
create or replace view View_Salario_Medio_Equipe as
	select e.nome as Equipes, avg(j.salario) as Salario_Medio
		from (select idEquipe, salario from jogadorbrasileiro
    union all
    select idEquipe, salario from jogadorestrangeiro) as j
join equipe e on j.idEquipe = e.id
group by e.nome;

select * from View_Salario_Medio_Equipe;

-- e) View_Equipes_Campeonatos
#Relaciona equipes aos campeonatos que disputaram.


-- f) View_Jogadores_Lesionados_Atualmente
# Mostra os jogadores que estão atualmente lesionados (usando a tabela e os inserts abaixo).

CREATE TABLE Lesao (
id INT AUTO_INCREMENT PRIMARY KEY,
idJogador INT,
tipo VARCHAR(32),
dataInicio DATE,
dataFim DATE,
FOREIGN KEY (idJogador) REFERENCES JogadorBrasileiro(id)
);

INSERT INTO Lesao (id, idJogador, tipo, dataInicio, dataFim) VALUES (2, 2, 'manha', '2018-05-
02','2025-10-03');
INSERT INTO Lesao (id, idJogador, tipo, dataInicio, dataFim) VALUES (1, 3, 'muscular', '2025-01-
01','2025-10-03');

-- ----------------------------------------------------------------------------------------------------

#PARTE 3(Consultando Views com Filtros e Ordenações)

-- a) 
-- b)
-- c) 


#PARTE 2(INDEX)
-- exercício 1) 
-- exercício 2)
-- exercício 3)
-- exercício 4)
DROP DATABASE IF EXISTS AVP2_ALEXANDRE_SANTOS;

CREATE DATABASE IF NOT EXISTS AVP2_ALEXANDRE_SANTOS;

USE AVP2_ALEXANDRE_SANTOS;

DROP TABLE IF EXISTS CAMINHAO;

#criar a tabela caminhao
CREATE TABLE IF NOT EXISTS CAMINHAO (
	CODIGOC INT NOT NULL,
    CAPACIDADE INT,
    MARCA VARCHAR(15) NOT NULL,
    MODELO VARCHAR(15) NOT NULL,
    PRIMARY KEY (CODIGOC)
);

DROP TABLE IF EXISTS PRODUTO;

#criar a tabela produto
CREATE TABLE IF NOT EXISTS PRODUTO (
	CODIGOP INT NOT NULL,
    MARCA VARCHAR(15) NOT NULL,
    NOME VARCHAR(15) NOT NULL,
    FABRICANTE VARCHAR(15) NOT NULL,
    PRIMARY KEY (CODIGOP)
);

DROP TABLE IF EXISTS MOTORISTA;

#criar a tabela motorista
CREATE TABLE IF NOT EXISTS MOTORISTA (
	CPF VARCHAR(15) NOT NULL,
    NOME VARCHAR(15) NOT NULL,
    IDADE INT NOT NULL,
    ENDERECO VARCHAR(25) NOT NULL,
    PRIMARY KEY (CPF)
);

DROP TABLE IF EXISTS VIAGEM;

#criar a tabela viagem
CREATE TABLE IF NOT EXISTS VIAGEM (
	DATA_INICIO DATE NOT NULL,
    DATA_FIM DATE,
    CPF VARCHAR(15) NOT NULL,
    CODIGOC INT NOT NULL,
    PRIMARY KEY (DATA_INICIO, CPF, CODIGOC),
    FOREIGN KEY (CPF)
		REFERENCES MOTORISTA (CPF)
        ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (CODIGOC)
		REFERENCES CAMINHAO (CODIGOC)
        ON UPDATE CASCADE ON DELETE CASCADE
);

# tabela transporta criada
DROP TABLE IF EXISTS TRANSPORTA;

CREATE TABLE IF NOT EXISTS TRANSPORTA (
    DATA_INICIO DATE NOT NULL,
    CPF VARCHAR(15) NOT NULL,
    CODIGOC INT NOT NULL,
    CODIGOP INT NOT NULL,
    PRIMARY KEY (DATA_INICIO , CPF , CODIGOC , CODIGOP),
    FOREIGN KEY (DATA_INICIO , CPF , CODIGOC)
        REFERENCES VIAGEM (DATA_INICIO , CPF , CODIGOC)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (CODIGOP)
        REFERENCES PRODUTO (CODIGOP)
        ON UPDATE CASCADE ON DELETE CASCADE
);

# ** INSERTS **

INSERT INTO CAMINHAO VALUES (1, NULL, 'MERCEDEZ', 'BW12');
INSERT INTO CAMINHAO VALUES (2, NULL, 'SCANIA', 'AD23');
INSERT INTO CAMINHAO VALUES (3, NULL, 'MERCEDEZ', 'TRUCK');
INSERT INTO CAMINHAO VALUES (4, NULL, 'FORD', 'ERON');
INSERT INTO CAMINHAO VALUES (5, NULL, 'SCANIA', 'THOR');

INSERT INTO PRODUTO VALUES (1, 'SOIL', 'SOJA', 'SOJALU');
INSERT INTO PRODUTO VALUES (2, 'GARLIC', 'ALHO', 'SOJALU');
INSERT INTO PRODUTO VALUES (3, 'ONION', 'CEBOLA', 'CREMESP');
INSERT INTO PRODUTO VALUES (4, 'SALT', 'SAL', 'CREMESP');
INSERT INTO PRODUTO VALUES (5, 'OIL', 'AZEITE', 'GALO');

INSERT INTO MOTORISTA VALUES ('123', 'CAROL', 32, 'RUA SAO BENTO, 22');
INSERT INTO MOTORISTA VALUES ('234', 'ANTONIO', 40, 'RUA JOAQUIM BARBOSA, 21');
INSERT INTO MOTORISTA VALUES ('456', 'JOANA', 28, 'RUA AMARANTHUS, 43');
INSERT INTO MOTORISTA VALUES ('347', 'LUIZ', 21, 'RUA GHOST, 54');
INSERT INTO MOTORISTA VALUES ('555', 'TEREZA', 55, 'RUA THEODORO, 66');

INSERT INTO VIAGEM VALUES ('2019-04-12', '2019-05-15', '123', 1);
INSERT INTO VIAGEM VALUES ('2019-05-15', '2019-06-16', '123', 2);
INSERT INTO VIAGEM VALUES ('2019-05-31', NULL, '234', 2);
INSERT INTO VIAGEM VALUES ('2019-07-08', NULL, '456', 3);
INSERT INTO VIAGEM VALUES ('2019-08-15', NULL, '347', 3);

INSERT INTO TRANSPORTA VALUES ('2019-04-12', '123', 1, 1);
INSERT INTO TRANSPORTA VALUES ('2019-05-15', '123', 2, 2);
INSERT INTO TRANSPORTA VALUES ('2019-05-31', '234', 2, 3);
INSERT INTO TRANSPORTA VALUES ('2019-07-08', '456', 3, 4);
INSERT INTO TRANSPORTA VALUES ('2019-08-15', '347', 3, 5);

# Responda as questões **SELECTS**:

#(A) mostre a quantidade de caminhões por marca
select count(marca) as quant_caminhao_marca from caminhao;

#(B) mostre todas as marcas de caminhão que possuem a letra c no nome
select marca from caminhao where marca like '%c%';

#(C) mostre quantos produtos estão cadastrados
select count(*) as produtos_cadastrados from produto;

#(D) quantos produtos são do fabricante SOJALU
select count(*) as Fabricante_SOJALU from produto where fabricante = 'SOJALU';

#(E) mostre todas as viagens que não foram finalizadas data fim e null
select * from viagem where data_fim is null;

#(F) mostre todas viagens que já foram finalizadas data fim não e null
select * from viagem where data_fim is not null;

#(G) mostre os dados dos motoristas nas viagens
select * from motorista m, viagem v where m.cpf = v.cpf;

#(H) mostre os dados do caminhão na viagem
select * from caminhao c, viagem v where c.codigoc = v.codigoc;

#(I) mostre os dados do motorista e os dados do caminhão na viagem
select m.*, c.* from motorista m, caminhao c, viagem v where m.cpf = v.cpf and c.codigoc = v.codigoc;

#(J) mostre os dados da viagem com os produtos transportados
select v.*, p.nome as produtos_transportados from viagem v, produto p, transporta t where p.codigop = t.codigop;

#(K) mostre os dados da viagem com os dados motorista, os dados do caminhão e os dados dos produtos
select v.*, m.*, c.*, p.* from viagem v, motorista m, caminhao c, produto p where v.codigoc = c.codigoc;

#(L) selecione as viagens não finalizadas do motorista Antônio
select v.*, m.nome from viagem v, motorista m where v.cpf = m.cpf and m.nome = 'Antonio' and v.data_fim is null;

#(M) selecione as viagens finalizadas da motorista Carol
select v.*, m.nome from viagem v, motorista m where v.cpf = m.cpf and m.nome = 'Carol' and v.data_fim is not null;

#(N) selecione todas as viagens com caminhões da marca Mercedes
select v.*, c.marca from viagem v, caminhao c where v.codigoc = c.codigoc and c.marca = 'Mercedez';

#(O) selecione todas as viagens que transportaram cebola ou alho
select v.*, p.nome from viagem v, produto p, transporta t where p.codigop = t.codigop and p.nome = 'cebola' or p.nome = 'alho';

#(P) Mostre o nome dos motoristas e, se houver, a data de início das viagens realizadas por eles.
-- (mostra todos os motoristas, mesmo os que nunca fizeram viagem)
select m.nome, v.data_inicio from motorista m left join viagem v on m.cpf = v.cpf;

#(Q) Mostre a marca e modelo dos caminhões que já foram usados em alguma viagem.
-- (mostra apenas caminhões que estão em viagens)
select c.marca, c.modelo from caminhao c inner join viagem v on c.codigoc = v.codigoc;
CREATE TABLE Animais(
id int,
nome varchar(50),
nasc date,
peso decimal(10,2),
cor varchar(50),
especie varchar (20),
primary key (id)
);

INSERT INTO Animais values (01, 'Ágata', date'2015-04-09', 13.9,
'branco', 'gato');
INSERT INTO Animais values (02, 'Félix', date'2016-06-06', 14.3, 'preto', 'gato');
INSERT INTO Animais values (03, 'Tom', date'2013-02-08', 11.2, 'azul', 'gato');
INSERT INTO Animais values (04, 'Garfield', date'2015-07-06', 17.1,
'laranja', 'cachorro');
INSERT INTO Animais values (05, 'Frajola', date'2013-08-01', 13.7,
'preto', 'gato');
INSERT INTO Animais values (06, 'Manda-chuva', date'2012-02-03', 12.3,
'amarelo', 'gato');
INSERT INTO Animais VALUES (07, 'Snowball', date'2014-04-06', 13.2,
'preto', 'cachorro');
INSERT INTO Animais values (10, 'Ágata', date'2015-08-03', 11.9, 'azul', 'cachorro');
INSERT INTO Animais values (11, 'Gato de Botas', date'2012-12-10', 11.6,
'amarelo', 'gato', 'cachorro');
INSERT INTO Animais VALUES (12, 'Kitty', date'2020-04-06', 11.6,
'amarelo', 'gato', 'cachorro');
INSERT INTO Animais VALUES (13, 'Milu', date'2013-02-04', 17.9, 'branco', 'cachorro');
INSERT INTO Animais values (14, 'Pluto', date'2019-11-03', 12.3,
'amarelo', 'cachorro');
INSERT INTO Animais values (15, 'Pateta', date'2015-05-01', 17.7,
'preto', 'cachorro');
INSERT INTO Animais values (16, 'Snoopy', date'2013-07-02', 18.2,
'branco', 'cachorro');
INSERT INTO Animais values (17, 'Rex', date'2019-11-03', 19.7, 'beje', 'cachorro');
INSERT INTO Animais values (20, 'Bidu', date'2012-09-08', 12.4, 'azul', 'cachorro');
INSERT INTO Animais values (21, 'Dum Dum', date'2015-04-06', 11.2,
'laranja', 'cachorro');
INSERT INTO Animais values (22, 'Muttley', date'2011-02-03', 14.3,
'laranja', 'gato');
INSERT INTO Animais VALUES (23, 'Scooby', date'2012-01-02', 19.9,
'marrom', 'cachorro');
INSERT INTO Animais values (24, 'Rufus', date'2014-04-05', 19.7,
'branco', 'cachorro');
INSERT INTO Animais values (25, 'Rex', date'2021-08-19', 19.7, 'branco', 'cachorro');
INSERT INTO Animais values (26, 'Luna', date'2021-01-11', 2.7, 'branco', 'coelho');
INSERT INTO Animais values (27, 'Pompom', date'2021-02-14', 4.7, 'preto', 'coelho');


CREATE TABLE Especie (
	Nome VARCHAR (50) NOT NULL,
    Nome_Cientifico VARCHAR(60) NOT NULL,
    Ordem VARCHAR(40) NOT NULL,
    Filo VARCHAR(40) NOT NULL,
    Reino VARCHAR(60) NOT NULL,
    Descricao VARCHAR(250),
    PRIMARY KEY (Nome)
);

INSERT INTO Especie (Nome, Nome_Cientifico, Ordem, Filo, Reino, Descricao) VALUES
('Cachorro', 'Canis lupus familiaris', 'Carnivora', 'Chordata', 'Animalia', 'O cachorro é um mamífero domesticado, amplamente conhecido como animal de estimação.'),
('Gato', 'Felis catus', 'Carnivora', 'Chordata', 'Animalia', 'O gato é um mamífero carnívoro, domesticado como animal de companhia.'),
('Coelho', 'Oryctolagus cuniculus', 'Lagomorpha', 'Chordata', 'Animalia', 'O coelho é um mamífero herbívoro conhecido por suas longas orelhas e hábitos de alimentação.');


ALTER TABLE Animais ADD CONSTRAINT fk_Especie FOREIGN KEY (Especie) REFERENCES Especie(Nome);

/* Altere o nome do Pateta para Goofy;*/ 
UPDATE Animais SET Nome = "Goofy" WHERE id = 15;

/* Altere o peso do Garfield para 10 quilogramas;*/
UPDATE Animais SET Peso = 10 WHERE id = 04;

/* Altere a cor de todos os gatos para laranja;*/
UPDATE Animais SET Cor = "laranja" WHERE especie = "gato";
/* Crie um campo altura para os animais;*/
ALTER TABLE Animais ADD Altura double (4,2);

/* Crie um campo observação para os animais;*/
ALTER TABLE Animais ADD Oberservacao varchar(100);

/* Remova todos os animais que pesam mais que 200 quilogramas.*/
DELETE FROM Animais WHERE Peso > 200; 
/* Remova todos os animais que o nome inicie com a letra ‘C’.*/
DELETE FROM Animais WHERE Nome LIKE 'c%';
/* Remova o campo cor dos animais;*/
ALTER TABLE Animais DROP COLUMN Cor;

/* Aumente o tamanho do campo nome dos animais para 80 caracteres;*/
ALTER TABLE Animais MODIFY COLUMN Nome varchar(80);
/* Remova todos os gatos e cachorros.*/
DELETE FROM Animais WHERE Especie = "gato" OR Especie = "cachorro"; 
/* Remova o campo data de nascimento dos animais.*/
ALTER TABLE Animais DROP COLUMN  nasc;
/* Remova todos os animais.*/
TRUNCATE TABLE Animais;
/* Remova a tabela especies.*/
TRUNCATE TABLE Especies;
/* Ou */
DROP TABLE Especies;

/* Exercício 1 */

SELECT * FROM Animais;
SELECT * FROM Especie;
SELECT * FROM Animais WHERE FK_Nome = "Cachorro";
SELECT * FROM Animais WHERE FK_Nome = "Gato";
SELECT * FROM Animais WHERE FK_Nome = "Coelho";

CREATE TABLE Animais (
    Nome VARCHAR(50) NOT NULL,
    Data_Nasc DATE NOT NULL,
    Peso DOUBLE(6,2) NOT NULL,
    ID_Animal INTEGER AUTO_INCREMENT NOT NULL,
    FK_Nome VARCHAR(60) NOT NULL,
    PRIMARY KEY (ID_Animal),
    FOREIGN KEY (FK_Nome) REFERENCES Especie(Nome)
);
DROP TABLE Animais;

CREATE TABLE Especie (
	Nome VARCHAR (50) NOT NULL,
    Nome_Cientifico VARCHAR(60) NOT NULL,
    Ordem VARCHAR(40) NOT NULL,
    Filo VARCHAR(40) NOT NULL,
    Reino VARCHAR(60) NOT NULL,
    Descricao VARCHAR(250),
    PRIMARY KEY (Nome)
);

-- Inserir espécies
INSERT INTO Especie (Nome, Nome_Cientifico, Ordem, Filo, Reino, Descricao) VALUES
('Cachorro', 'Canis lupus familiaris', 'Carnivora', 'Chordata', 'Animalia', 'O cachorro é um mamífero domesticado, amplamente conhecido como animal de estimação.'),
('Gato', 'Felis catus', 'Carnivora', 'Chordata', 'Animalia', 'O gato é um mamífero carnívoro, domesticado como animal de companhia.'),
('Coelho', 'Oryctolagus cuniculus', 'Lagomorpha', 'Chordata', 'Animalia', 'O coelho é um mamífero herbívoro conhecido por suas longas orelhas e hábitos de alimentação.');

-- Inserir animais
INSERT INTO Animais (Nome, Data_Nasc, Peso, FK_Nome) VALUES
('Rex', '2019-05-15', 15.5, 'Cachorro'),
('Branquinha', '2018-08-20', 4.2, 'Gato'),
('Pompom', '2017-12-10', 2.7, 'Coelho'),
('Toby', '2020-02-28', 12.0,'Cachorro'),
('Mia', '2016-10-03', 3.0, 'Gato'),
('Frajola', '2015-07-25', 1.8,'Coelho'),
('Rocky', '2021-04-12', 18.0,'Cachorro'),
('Luna', '2019-09-08', 5.5,'Gato');

/* Exercício 2 */

SELECT * FROM Produtos;
SELECT * FROM Marcas;
SELECT * FROM Produtos WHERE FK_ID_Marca = 1;
SELECT * FROM Produtos WHERE FK_ID_Marca = 2;
SELECT * FROM Produtos WHERE FK_ID_Marca = 3;


CREATE TABLE Produtos (
Nome VARCHAR(60) NOT NULL,
Preco_de_venda DOUBLE (6,2) NOT NULL,
data_de_validade DATE NOT NULL,
ID_Marca INTEGER NOT NULL,
ID_Produto INTEGER AUTO_INCREMENT NOT NULL,
FK_ID_Marca INTEGER NOT NULL,
PRIMARY KEY (ID_Produto),
FOREIGN KEY (FK_ID_Marca) REFERENCES Marcas (ID_Marca)
);


CREATE TABLE Marcas (
Nome VARCHAR (60) NOT NULL,
Site_oficial VARCHAR(100) NOT NULL,
Telefone VARCHAR(20) NOT NULL,
ID_Marca INTEGER AUTO_INCREMENT NOT NULL,
PRIMARY KEY (ID_Marca)
);

INSERT INTO Marcas (Nome, Site_oficial, Telefone) VALUES
('Apple', 'https://www.apple.com/', '+1-800-275-2273'),
('Samsung', 'https://www.samsung.com/', '+1-800-726-7864'),
('Nike', 'https://www.nike.com/', '+1-800-806-6453');

-- Inserir produtos
INSERT INTO Produtos (Nome, Preco_de_venda, data_de_validade, FK_ID_Marca) VALUES
('iPhone 13 Pro', 8500.00, '2024-12-31', 1),
('Galaxy S21 Ultra', 2199.99, '2024-12-31', 2),
('AirPods Pro', 3500.00, '2024-12-31', 1),
('Samsung Galaxy Watch 4', 1399.99, '2024-12-31', 2),
('Nike Air Force 1', 900.00, '2024-12-31', 3),
('MacBook Pro 14"', 10999.00, '2024-12-31', 1),
('Samsung 49" QLED TV', 4299.99, '2024-12-31', 2),
('Nike Air Max 270', 800.00, '2024-12-31', 3);

/* Exerício 3 */

SELECT * FROM Filmes;
SELECT * FROM Categorias;
SELECT * FROM Filmes WHERE fk_Categorias_Nome = "Ação";
SELECT * FROM Filmes WHERE fk_Categorias_Nome = "Romance";
SELECT * FROM Filmes WHERE fk_Categorias_Nome = "Drama";


CREATE TABLE Filmes (
    Titulo VARCHAR(60) NOT NULL,
    Sinopse VARCHAR(200) NOT NULL,
    ID_Filme INTEGER AUTO_INCREMENT NOT NULL,
    Estudio VARCHAR (30) NOT NULL,
    fk_Categorias_Nome VARCHAR (20),
	PRIMARY KEY (ID_Filme),
    FOREIGN KEY (fk_Categorias_Nome) REFERENCES Categorias(Nome)
);


CREATE TABLE Categorias (
    Nome VARCHAR (20),
    Publico_Alvo VARCHAR (10),
    PRIMARY KEY (Nome)
);

-- Inserir categorias
INSERT INTO Categorias (Nome, Publico_Alvo) VALUES
('Drama', 'Adulto'),
('Romance', 'Adulto'),
('Ação', 'Adulto');

INSERT INTO Filmes (Titulo, Sinopse, Estudio, fk_Categorias_Nome) VALUES
('In The Mood For Love', 'Em Hong Kong, nos anos 60, dois vizinhos se apaixonam, mas mantêm uma relação platônica.', 'Jet Tone Production', 'Romance'),
('Pearl', 'Presa em uma fazenda isolada, Pearl deve cuidar de seu pai doente sob a vigilância de sua mãe.', 'A24', 'Drama'),
('Aftersun', 'Sophie reflete sobre a alegria e a melancolia das férias que ela tirou com seu pai 20 anos antes.', 'A24', 'Drama'),
('Everything Everywhere All At Once', 'Uma ruptura interdimensional bagunça a realidade e uma inesperada heroína precisa usar seus novos poderes para lutar contra os perigos bizarros do multiverso.', 'A24', 'Ação'),
('Happy Together', 'Lai e seu namorado Ho chegam à Argentina de Hong Kong, buscando uma vida melhor. ', 'Jet Tone Production', 'Romance'),
('Before Sunrise', 'Jesse e Celine se conhecem no trem para Paris, e começam uma conversa que os leva a fazer uma escala em Viena, sem imaginar o que o destino os reserva.', 'Castle Rock Entertainment', 'Romance'),
('The Devil Wears Prada', 'Andy é uma jovem que consegue um emprego na renomada "Runway Magazine", a mais importante revista de moda de Nova York.', '20th Century Studios', 'Drama'),
('The Hunger Games', 'Num futuro distópico, jovens são selecionados para lutar até a morte num reality show macabro chamado Jogos Vorazes, desafiando a opressão do governo e lutando por sobrevivência.', 'Lionsgate Entertainment', 'Ação');

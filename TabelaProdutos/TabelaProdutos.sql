CREATE TABLE Produtos (
ID_Produto INTEGER NOT NULL AUTO_INCREMENT,
Nome VARCHAR(50) NOT NULL,
Preco DOUBLE(5,2) NOT NULL,
Estoque INTEGER NOT NULL,
Perecivel BOOLEAN  NOT NULL,
Marca VARCHAR (40),
Nacionalidade VARCHAR(40),
PRIMARY KEY (ID_Produto)
);

drop table Produtos;

INSERT INTO Produtos (Nome, Preco, Estoque, Perecivel, Marca, Nacionalidade) VALUES
('Arroz', 10.99, 100, false, 'Tio João', 'Brasil'),
('Leite', 3.50, 50, true, 'Nestlé', 'Suíça'),
('Café', 8.75, 80, false, 'Melitta', 'Brasil'),
('Sabão em Pó', 15.25, 120, false, 'OMO', 'Brasil'),
('Maçã', 2.50, 30, true, 'Fuji', 'Brasil'),
('Chocolate Amargo', 9.99, 25, false, 'Lindt', 'Suíça'),
('Sabonete Líquido', 12.50, 60, false, 'Natura', 'Brasil'),
('Espaguete', 2.75, 80, false, 'Renata', 'Brasil'),
('Desodorante', 7.25, 45, false, 'Dove', 'Estados Unidos'),
('Banana', 2.00, 35, true, 'Prata', 'Brasil'),
('Feijão', 7.99, 90, false, 'Camil', 'Brasil'),
('Manteiga', 6.25, 40, true, 'Aviação', 'Brasil'),
('Pão de Forma', 4.50, 60, true, 'Wickbold', 'Brasil'),
('Biscoito Recheado', 3.75, 75, false, 'Nestlé', 'Brasil'),
('Tomate', 1.99, 50, true, 'Carmen', 'Brasil'),
('Arroz', 12.50, 80, false, 'Camil', 'Brasil'),
('Leite', 4.00, 60, false, 'Parmalat', 'Itália'),
('Café', 9.50, 70, false, 'Pilão', 'Brasil'),
('Sabão em Pó', 17.50, 110, false, 'Ariel', 'Brasil'),
('Chocolate Amargo', 11.50, 30, false, 'Hershey', 'Estados Unidos'),
('Sabonete Líquido', 14.00, 70, false, 'Johnson & Johnson', 'Estados Unidos'),
('Espaguete', 3.25, 90, false, 'Barilla', 'Itália'),
('Desodorante', 8.25, 50, false, 'Rexona', 'Reino Unido'),
('Feijão', 9.99, 100, false, 'Preto', 'Brasil'),
('Manteiga', 7.50, 60, false, 'Primor', 'Brasil'),
('Pão de Forma', 5.00, 80, false, 'Pullman', 'Brasil'),
('Biscoito Recheado', 4.25, 85, false, 'Oreo', 'Estados Unidos');

/* Gere um relatório informando quantos produtos estão cadastrados; */

SELECT COUNT(ID_Produto) FROM Produtos;

/* Gere um relatório informando o preço médio dos produtos; */
SELECT AVG(Preco) as preco_medio FROM Produtos;

/* Selecione a média dos preços dos produtos em 2 grupos: perecíveis e não perecíveis;*/
SELECT AVG(Preco) as preco_medio_pereciveis FROM Produtos WHERE Perecivel = true;
SELECT AVG(Preco) as preco_medio_nao_pereciveis FROM Produtos WHERE Perecivel = false;
/* Ou */
SELECT Perecivel, AVG(Preco) AS preco_media FROM Produtos GROUP BY Perecivel;

/* Selecione a média dos preços dos produtos agrupados pelo nome do produto;*/
SELECT Nome, AVG(Preco) AS preco_media FROM Produtos GROUP BY Nome;

/* Selecione a média dos preços e total em estoque dos produtos;*/
SELECT AVG(Preco) as preco_medio, SUM(Estoque) AS total_estoque FROM Produtos;

/* Selecione o nome, marca e quantidade em estoque do produto mais caro;*/

SELECT Nome, Marca, Estoque FROM Produtos WHERE Preco = (SELECT MAX(Preco) FROM Produtos);

/* Selecione os produtos com preço acima da média;*/

SELECT * FROM Produtos WHERE Preco > (SELECT AVG(Preco) as preco_medio FROM Produtos);

/* Selecione a quantidade de produtos de cada nacionalidade.*/

SELECT Nacionalidade, COUNT(ID_Produto) FROM Produtos GROUP BY Nacionalidade;



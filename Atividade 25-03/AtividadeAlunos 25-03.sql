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


INSERT INTO Produtos (Nome, Preco, Estoque, Perecivel, Marca, Nacionalidade) VALUES 
('Arroz', 10.99, 100, false, 'Tio João', 'Brasil'),
('Leite', 3.50, 50, true, 'Nestlé', 'Suíça'),
('Café', 8.75, 80, false, 'Melitta', 'Brasil'),
('Sabão em Pó', 15.25, 120, false, 'OMO', 'Brasil'),
('Maçã', 2.50, 30, true, 'Fuji', 'Brasil');

CREATE TABLE Cidades (
	id INTEGER,
	nome VARCHAR (60) NOT NULL,
	populacao INTEGER,
	PRIMARY KEY (id)
);

drop table Alunos;
CREATE TABLE Alunos (
	id INTEGER,
	Nome VARCHAR(60) NOT NULL,
	Data_Nasc DATE,
	Cidade_ID INTEGER, 
	FOREIGN KEY (Cidade_ID) REFERENCES Cidades (id)
);

INSERT INTO Cidades VALUES 
(1, 'Arraial dos Tucanos', 42632),
(2, 'Springfield', 13820),
(3, 'Hill Valey', 27383),
(4, 'Coruscant', 19138),
(5, 'Minas Tirith', 31394);

INSERT INTO Alunos VALUES 
(1, 'Immanuel Kant', '1724-04-22', 4),
(2, 'Alan Turing', '1912-06-23', 3),
(3, 'George Boole', '2002-01-01', 1),
(4, 'Lynn Margulis', '1991-08-12', 3),
(5, 'Nicola Tesla', '2090-01-08', null),
(6, 'Ada Lovelace', '1978-05-28', 4),
(7, 'Claude Shannon', '1982-10-15', 3),
(8, 'Charles Darwin', '2010-02-06', null),
(9, 'Marie Curie', '2007-07-12', 3),
(10, 'Carl Sagan', '2000-11-20', 1),
(11, 'Tim Berners-Lee', '1973-12-05', 4),
(12, 'Richard Feynman', '1982-09-12', 1);

select * from Alunos inner join Cidades on Cidades.id = alunos.cidade_id;

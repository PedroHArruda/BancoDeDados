/* ListaExercicios: */

select * from clientes;
select * from animais;

select * from desenvolvedores;
select * from projetos;

select * from automoveis;
select * from montadora;

select * from produtos;
select * from marca;

select * from atores;
select * from elenco;
select * from filmes;
select * from diretores;

select * from alunos;
select * from matricula;
select * from disciplina;

select * from colaboradores;

/* Exercício 1 - Clientes e animais (1:N) */
CREATE TABLE Clientes (
    email varchar (50) not null,
    CPF_PK bigint not null,
    nome varchar (100) not null,
    primary key (CPF_PK)
);

CREATE TABLE Animais (
    especie varchar(50) not null,
    data_de_nasc date not null,
    nome varchar(50) not null,
    FK_CPF bigint,
    ID_animal_PK integer not null auto_increment,
    primary key (ID_animal_PK),
    foreign key (FK_CPF) references Clientes (CPF_PK)
);

-- Registros para a tabela Clientes
INSERT INTO Clientes VALUES 
('joao@gmail.com', 12345678901, 'João Silva'),
('maria@gmail.com', 23456789012, 'Maria Oliveira'),
('carlos@gmail.com', 34567890123, 'Carlos Santos'),
('ana@gmail.com', 45678901234, 'Ana Pereira'),
('pedro@gmail.com', 56789012345, 'Pedro Rocha'),
('lucia@gmail.com', 67890123456, 'Lucia Lima');
select * from Clientes;

-- Registros para a tabela Animais
INSERT INTO Animais (especie, data_de_nasc, nome, FK_CPF) VALUES
('Cachorro', '2020-01-15', 'Amora', 12345678901),
('Gato', '2019-05-20', 'Django', 23456789012),
('Cachorro', '2018-11-10', 'Trix', 34567890123),
('Gato', '2022-02-28', 'Fang', 45678901234),
('Gato', '2021-07-08', 'Daisy', 56789012345),
('Cachorro', '2020-04-03', 'Lecter', 67890123456);
SELECT * FROM animais;


/* Exercício 2 - Desenvolvedores e Projetos (1:N) */

CREATE TABLE Projetos (
    data_de_lancamento date not null,
    nome varchar (100) not null,
    genero varchar (20) not null,
    faixa_etaria integer not null,
	ID_projeto_PK integer not null auto_increment,
    primary key (ID_projeto_PK)
);

CREATE TABLE Desenvolvedores (
    data_de_nasc date,
    CPF_PK bigint, 
    nome varchar(50),
    FK_ID_projeto integer,
    primary key (CPF_PK),
    foreign key (FK_ID_projeto) references Projetos (ID_projeto_PK)
);

-- Registros para a tabela Projetos
INSERT INTO Projetos (data_de_lancamento, nome, genero, faixa_etaria) VALUES
('2024-03-15', 'Chronicles of Arcadia: Dawn of Destiny', 'Aventura', 12),
('2024-07-15', 'Galactic Conquest: Frontier Warfare', 'Estratégia', 14),
('2024-11-22', 'Eternal Legends: Rise of the Ancients', 'RPG', 14),
('2024-04-10', 'Shadow Realms: Echoes of Darkness', 'Ação', 16),
('2024-09-05', 'Nexus Assault: Battle for Supremacy', 'FPS', 18),
('2024-11-12', 'Mystic Odyssey: Secrets of the Lost Realm', 'Aventura', 10);
SELECT * FROM projetos;


-- Registros para a tabela Desenvolvedores
INSERT INTO Desenvolvedores (data_de_nasc, CPF_PK, nome, FK_ID_projeto) VALUES
('1990-03-12', 98765432109, 'Carlos Oliveira', 1),
('1985-08-25', 87654321098, 'Amanda Santos', 2),
('1988-11-30', 76543210987, 'Pedro Lima', 3),
('1992-05-18', 65432109876, 'Marina Rocha', 4),
('1980-09-03', 54321098765, 'Lucas Pereira', 5),
('1995-02-14', 43210987654, 'Camila Silva', 6);
SELECT * FROM desenvolvedores;


/* Exercício 3 - Livros e Autores (1:N) */
CREATE TABLE Autores (
    data_de_nasc date not null,
    nacionalidade varchar(20) not null,
    nome varchar(100) not null,
    email varchar(100) not null,
    ID_autor_PK integer not null auto_increment,
	primary key (ID_autor_PK)
);

CREATE TABLE Livros (
    quantidade_de_paginas integer not null,
    nome varchar (100) not null,
    acabamento varchar (50) not null,
    editora varchar (40) not null,
    FK_ID_autor integer,
    ISBN_PK bigint not null,
    primary key (ISBN_PK),
    foreign key (FK_ID_autor) references Autores (ID_autor_PK)
);

-- Registros para a tabela Autores
INSERT INTO Autores (data_de_nasc, nacionalidade, nome, email) VALUES
('1983-12-20', 'Americana', 'Taylor Jenkins Reid', 'taylorjenkinsreid@gmail.com'),
('1975-12-10', 'Inglesa', 'Alice Oseman', 'aliceoseman@gmail.com'),
('1964-10-18', 'Brasileira', 'Carla Madeira', 'carlamadeira@gmail.com'),
('1970-09-15', 'Brasileiro', 'Pedro Rhuas', 'pedrorhuas@gmail.com'),
('1993-02-10', 'Brasileira', 'Bel Rodrigues', 'belrodrigues13@gmail.com'),
('1986-07-03', 'Brasileira', 'Carmen Maria Machado', 'carmenmariamachado@gmail.com');

select * from Autores;

INSERT INTO Livros (quantidade_de_paginas, nome, acabamento, editora, FK_ID_autor, ISBN_PK) VALUES
(360, 'The Seven Husbands of Evelyn Hugo', 'Capa Dura', 'Paralela', 1, 1234567890),
(250, 'Heartstopper', 'Capa Dura', 'Companhia das Letras', 2, 2345678901),
(400, 'Tudo é Rio', 'Capa Dura', 'Grupo Editorial Record.', 3, 3456789012),
(350, 'Enquanto Eu Não Te Encontro', 'Brochura', 'Seguinte', 4, 4567890123),
(304, '13 segundos', 'Capa Dura', 'Galera', 5, 5678901234),
(360, 'Na Casa dos Sonhos', 'Brochura', 'Companhia das Letras', 6, 6789012345);

select * from Livros;


/* Exercício 4 - Automóveis e Montadora (1:N) */

CREATE TABLE Montadora (
	ID_montadora_PK integer not null auto_increment,
    nome varchar(100) not null,
    logotipo varchar (100),
    primary key (ID_montadora_PK)
);

CREATE TABLE Automoveis (
	chassi_PK bigint not null,
    placa varchar(10) not null,
    modelo varchar(30) not null,
    FK_ID_montadora integer,
    ano integer not null,
    primary key(chassi_PK),
    foreign key (FK_ID_montadora) references Montadora (ID_montadora_PK)
);



-- Registros para a tabela Montadora
INSERT INTO Montadora (nome, logotipo) VALUES
('Honda', 'logo_a.png'),
('Volkswagen', 'logo_b.png'),
('Toyota', 'logo_c.png'),
('BMW', 'logo_d.png'),
('Ford', 'logo_e.png'),
('Mercedes-Benz', 'logo_f.png');

select * from Montadora;

-- Registros para a tabela Automóveis
INSERT INTO Automoveis (chassi_PK, placa, modelo, ano, FK_ID_montadora) VALUES
(123456789, 'ABC1234', 'Civic', 2020, 1),
(234567890, 'DEF5678', 'Golf', 2019, 2),
(345678901, 'GHI9012', 'Corolla', 2021, 3),
(456789012, 'JKL3456', 'Mustang', 2020, 5),
(567890123, 'MNO6789', 'S-Class', 2022, 6),
(678901234, 'PQR1234', '3 Series', 2021, 4);

select * from automoveis;

/* Exercício 5 - Produtos e Marca (1:N) */

CREATE TABLE Marca (
    nacionalidade varchar (20) not null, 
    SAC bigint not null,
    nome varchar(100) not null,
    ID_marca_PK integer not null auto_increment,
    primary key(ID_Marca_PK)
);

CREATE TABLE Produtos (
    nome varchar(50) not null,
    estoque integer not null,
    preco double(5,2) not null,
    ID_produto_PK integer not null auto_increment,
    FK_ID_marca integer,
    primary key (ID_produto_PK),
	foreign key (FK_ID_marca) references Marca (ID_marca_PK)
);

-- Registros para a tabela Marca
INSERT INTO Marca (nacionalidade, SAC, nome) VALUES
('Suiça', 0800123456, 'Logitech'),
('Estadunidense', 1800234567, 'Razer'),
('Estadunidense', 0800345678, 'Apple'),
('Estadunidense', 1800456789, 'Corsair'),
('Estadunidense', 0800567890, 'HyperX'),
('Brasileira', 1800678901, 'Redragon');

select * from Marca;

-- Registros para a tabela Produtos
INSERT INTO Produtos (nome, estoque, preco, FK_ID_marca) VALUES
('Mouse MX Master 3', 100, 549.99, 1),
('Teclado BlackWidow Elite 3', 75, 899.99, 2),
('Magic Mouse 2', 50, 810.00, 3),
('Teclado K55 RGB', 120, 349.90, 4),
('Teclado Alloy FPS RGB', 80, 449.99, 5),
('Headset Zeus X', 60, 269.99, 6);

select * from produtos;


/* Exercício 4 - Atores, Diretores e Filmes (N:N  - Atores e Filmes) e (1:N - Filmes e Diretores)  */
CREATE TABLE Atores (
	ID_ator_PK integer not null auto_increment, 
    data_de_nasc date not null,
    nacionalidade varchar (20) not null,
    nome varchar (100) not null,
    primary key (ID_ator_PK)
);

CREATE TABLE Elenco (
	FK_ID_ator integer,
    FK_ID_filme integer
);


CREATE TABLE Filmes (
	ID_filme_PK integer not null auto_increment,
    preco double(4,2) not null,
    titulo varchar (100) not null,
    duracao integer not null,
    FK_ID_diretor integer,
    idioma_original varchar (20) not null,
    primary key (ID_Filme_PK),
    foreign key (FK_ID_diretor) references Diretores (ID_diretor_PK)
);

alter table Elenco add constraint fk_elenco_1
foreign key (FK_ID_ator)
references Atores (ID_ator_PK);

alter table Elenco add constraint fk_elenco_2
foreign key (FK_ID_filme)
references Filmes (ID_filme_PK);

CREATE TABLE Diretores (
    nome varchar (100) not null,
    nacionalidade varchar (20) not null,
    data_de_nasc date not null,
    ID_diretor_PK integer not null auto_increment,
    primary key (ID_diretor_PK)
);

-- Registros para a tabela Atores
INSERT INTO Atores (data_de_nasc, nacionalidade, nome) VALUES
('1994-09-29', 'Inglês', 'Nicholas Galitzine'),
('1978-04-30', 'Alemã', 'Sandra Hüller'),
('1988-11-06', 'Americana', 'Emma Stone'),
('1962-08-06', 'Malaia', 'Michelle Yeoh'),
('1991-01-07', 'Americana', 'MJ Rodriguez'),
('1962-07-27', 'Honconguês', 'Tony Leung Chiu-Wai');
select * from Atores;

insert into elenco (FK_ID_ator, FK_ID_filme) values 
(1, 1),
(2, 2), 
(3, 3),
(4, 4),
(5, 5),
(6, 6);
select * from elenco;

-- Registros para a tabela Diretores
INSERT INTO Filmes (preco, titulo, duracao, idioma_original, FK_ID_diretor) VALUES
(29.99, 'Red, White & Royal Blue', 120, 'Inglês', 1),
(39.99, 'Anatomy Of a Fall', 151, 'Inglês', 2),
(19.99, 'Poor Things', 141, 'Inglês', 3),
(49.99, 'Everything Everywhere All at Once', 139, 'Inglês', 4),
(59.99, 'Pose', 90, 'Português', 5),
(69.99, 'Happy Together', 96, 'Mandarim', 6);
select * from filmes;

-- Registros para a tabela Diretores
INSERT INTO Diretores (nome, nacionalidade, data_de_nasc) VALUES
('Matthew López', 'Americano', '1977-03-24'),
('Justine Triet', 'Francesa', '1978-07-17'),
('Yorgos Lanthimos', 'Grego', '1973-09-23'),
('Daniel Kwan', 'Americano', '1988-02-10'),
('Ryan Murphy', 'Americano', '1965-11-09'),
('Wong Kar-Wai', 'Chinês', '1958-07-17');
select * from diretores;

/* Exercício 7 */

CREATE TABLE Alunos (
    RA_PK integer not null,
    data_Nasc date not null,
    email varchar(50) not null,
    endereco varchar(100) not null,
    nome varchar(60) not null,
    primary key (RA_PK)
);

INSERT INTO Alunos (RA_PK, data_Nasc, email, endereco, nome) VALUES 
    (234951, '2000-05-15', 'joaosilva@gmail.com', 'Rua Joubert Wey, 45', 'João Silva'),
    (235123, '2001-08-20', 'mariasantos@gmail.com', 'Rua Leopoldo Machado, 362', 'Maria Santos'),
    (223344, '1999-12-10', 'carlossouza@gmail.com', 'R. Otávio Moreira Farrapo, 64126', 'Carlos Souza'),
    (248765, '2002-03-25', 'anaoliveira@gmail.com', 'Rua Manoel Moreira Farrapo, 221', 'Ana Oliveira'),
    (239818, '2000-10-05', 'pedrolima@gmail.com', 'Av. Pedro Pires de Mello, 28,', 'Pedro Lima'),
    (239612, '2003-07-18', 'lucascosta@gmail.com', 'Rua Francisco de Barros Leite, 175, ', 'Lucas Costa');
	
    select * from Alunos;

CREATE TABLE Disciplina (
    ID_Disciplina_PK integer auto_increment not null,
    nome varchar(25) not null,
    carga_horaria integer not null,
    primary key (ID_Disciplina_PK)
);


INSERT INTO Disciplina (nome, carga_horaria) VALUES 
    ('Análise de Dados', 80),
    ('Contabilidade', 80),
    ('Design Thinking', 80),
    ('Gestão de Projetos', 80),
    ('Fisiologia', 80),
    ('História da Arte', 40);

	select * from Disciplina;

CREATE TABLE matricula (
    FK_RA integer,
    FK_ID_Disciplina integer,
    ID_Matricula_PK integer auto_increment not null,
    primary key (ID_Matricula_PK)
);
 
ALTER TABLE matricula ADD CONSTRAINT FK_matricula_1
    FOREIGN KEY (FK_RA)
    REFERENCES Alunos (RA_PK); 
ALTER TABLE matricula ADD CONSTRAINT FK_matricula_2
    FOREIGN KEY (FK_ID_Disciplina)
    REFERENCES Disciplina (ID_Disciplina_PK);
    
insert into matricula (FK_ID_Disciplina, FK_RA) values 
	(234951, 1),
	(235123, 2),
    (223344, 3),
    (248765, 4),
    (239818, 5),
    (239612, 6);
    
 select * from matricula; 

 
/* Exercício 8  */ 

CREATE TABLE Colaboradores (
    salario double not null,
    CPF bigint not null,
    cargo varchar(30) not null,
    ID_Colaborador_PK integer auto_increment not null,
    nome varchar(50),
    primary key (ID_Colaborador_PK)
);

INSERT INTO Colaboradores (salario, CPF, cargo, nome) VALUES 
    (3500.00, 19449702071, 'Gerente', 'João Andrade'),
    (2700.00, 87881953098, 'Analista de Marketing', 'Mateus Oliveira'),
    (2800.00, 85316751035, 'Desenvolvedor Web', 'Lucas Santos'),
    (5800.00, 11396267018, 'Engenheiro de Software', 'Isabel Sicolin'),
    (2400.00, 8562938068, 'Designer Gráfico', 'Elisabeth Rios'),
    (2600.00, 51306450063, 'Analista de RH', 'Emanuelle Gonçalves');

select * from Colaboradores;
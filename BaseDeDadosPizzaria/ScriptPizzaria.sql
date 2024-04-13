create table Receita(
	ID_Receita int auto_increment, 
    Instrucoes varchar(500) not null,
    Autor varchar(60) not null,
    primary key (ID_Receita)
);

create table Pizzaiolo(
	idPizzaiolo int auto_increment,
    nome varchar(65) not null, 
    salario double not null,
    especialidade varchar(55),
    primary key (idPizzaiolo)
);

create table Ingredientes(
	idIngredientes int auto_increment,
    nome_ingrediente varchar(100),
    primary key (idIngredientes)
);

create table Pizza_Ingredientes(
	idIngredientes int,
    ID_Pizza int,
    foreign key (idIngredientes) references Receita(idIngredientes),
    foreign key (ID_Pizza) references Pizza(ID_Pizza)
);

create table Pizza(
	ID_Pizza int auto_increment,
    sabor varchar(45) not null,
    preco double not null,
    descricao varchar(200) not null,
    tamanho varchar(10) not null, 
    material_embalagem varchar(45) not null,
    preco_embalagem double not null, 
    tamanho_embalagem varchar(10) not null,
    ID_Receita int,
    primary key (ID_Pizza),
    foreign key (ID_Receita) references Receita(ID_Receita)
);



create table Pizza_Pizzaiolo(
	ID_Pizza int,
    idPizzaiolo int,
    foreign key (ID_Pizza) references Pizza(ID_Pizza),
    foreign key (idPizzaiolo) references Pizzaiolo(idPizzaiolo)
);


INSERT INTO Receita (Instrucoes, Autor) VALUES
('Instruções para Pizza de Calabresa', 'Chef Ana Maria'),
('Instruções para Pizza Margherita', 'Chef João Carlos'),
('Instruções para Pizza Quatro Queijos', 'Chef Marta Oliveira'),
('Instruções para Pizza Portuguesa', 'Chef André Souza'),
('Instruções para Pizza Frango com Catupiry', 'Chef Carla Silva'),
('Instruções para Pizza Pepperoni', 'Chef Rodrigo Nunes'),
('Instruções para Pizza Vegetariana', 'Chef Ana Paula'),
('Instruções para Pizza Supreme', 'Chef Carlos Ferreira'),
('Instruções para Pizza Bacon', 'Chef Mariana Almeida'),
('Instruções para Pizza Napolitana', 'Chef Pedro Santos'),
('Instruções para Pizza Caprese', 'Chef Laura Oliveira'),
('Instruções para Pizza Rúcula com Tomate Seco', 'Chef Rafael Lima'),
('Instruções para Pizza Alho e Óleo', 'Chef Patrícia Silva'),
('Instruções para Pizza Atum', 'Chef Gustavo Santos'),
('Instruções para Pizza Chocolate', 'Chef Júlia Costa'),
('Instruções para Pizza Banana com Canela', 'Chef Matheus Alves'),
('Instruções para Pizza Calabresa Especial', 'Chef Ana Beatriz'),
('Instruções para Pizza Frango Frito', 'Chef Marcos Lima'),
('Instruções para Pizza Quatro Estações', 'Chef Luiza Almeida'),
('Instruções para Pizza Doce de Leite', 'Chef Miguel Santos'),
('Instruções para Pizza Morango com Chocolate', 'Chef Camila Ferreira'),
('Instruções para Pizza Mexicana', 'Chef Thiago Costa'),
('Instruções para Pizza Pesto', 'Chef Mariana Alves'),
('Instruções para Pizza Alcachofra', 'Chef Roberto Lima'),
('Instruções para Pizza Filé Mignon', 'Chef Juliana Oliveira'),
('Instruções para Pizza Vegana', 'Chef André Costa'),
('Instruções para Pizza Lombinho Canadense', 'Chef Camila Almeida'),
('Instruções para Pizza Dois Amores', 'Chef Felipe Santos'),
('Instruções para Pizza Margherita Especial', 'Chef Renata Costa');

INSERT INTO Pizzaiolo (nome, salario, especialidade) VALUES
('Lucas Oliveira', 2500.00, 'Pizza de Calabresa'),
('Maria Santos', 2800.00, 'Pizza Margherita'),
('Pedro Almeida', 2700.00, 'Pizza Quatro Queijos'),
('Ana Costa', 2600.00, 'Pizza Portuguesa'),
('Carlos Silva', 2600.00, 'Pizza Frango com Catupiry'),
('Mariana Souza', 2700.00, 'Pizza Pepperoni'),
('João Lima', 2500.00, 'Pizza Vegetariana'),
('Isabela Alves', 2600.00, 'Pizza Supreme'),
('Rafael Santos', 2800.00, 'Pizza Bacon'),
('Juliana Oliveira', 2700.00, 'Pizza Napolitana'),
('Rodrigo Silva', 2600.00, 'Pizza Caprese'),
('Patrícia Almeida', 2700.00, 'Pizza Rúcula com Tomate Seco'),
('Gustavo Ferreira', 2500.00, 'Pizza Alho e Óleo'),
('Carolina Costa', 2600.00, 'Pizza Atum'),
('Felipe Alves', 2700.00, 'Pizza Chocolate'),
('Luiza Santos', 2800.00, 'Pizza Banana com Canela'),
('Matheus Oliveira', 2600.00, 'Pizza Calabresa Especial'),
('Daniela Silva', 2700.00, 'Pizza Frango Frito'),
('Thiago Almeida', 2500.00, 'Pizza Quatro Estações'),
('Amanda Costa', 2600.00, 'Pizza Doce de Leite'),
('José Santos', 2700.00, 'Pizza Morango com Chocolate'),
('Laura Oliveira', 2800.00, 'Pizza Mexicana'),
('Fernando Silva', 2600.00, 'Pizza Pesto'),
('Beatriz Alves', 2700.00, 'Pizza Alcachofra'),
('Lucas Costa', 2500.00, 'Pizza Filé Mignon'),
('Carla Santos', 2600.00, 'Pizza Vegana'),
('Gabriel Oliveira', 2700.00, 'Pizza Lombinho Canadense'),
('Camila Almeida', 2800.00, 'Pizza Dois Amores'),
('Vinícius Silva', 2600.00, 'Pizza Margherita Especial');

INSERT INTO Ingredientes (nome_ingrediente) VALUES
('Molho de Tomate'),
('Queijo Mozzarella'),
('Calabresa'),
('Cebola'),
('Tomate'),
('Orégano'),
('Parmesão'),
('Bacon'),
('Presunto'),
('Ovo'),
('Catupiry'),
('Frango'),
('Pepperoni'),
('Pimentão'),
('Cogumelos'),
('Azeitonas'),
('Atum'),
('Chocolate ao Leite'),
('Banana'),
('Canela'),
('Doce de Leite'),
('Morangos'),
('Pimenta Mexicana'),
('Molho Pesto'),
('Alcachofra'),
('Filé Mignon'),
('Molho Barbecue'),
('Lombinho Canadense'),
('Chocolate Branco'),
('Goiabada'),
('Cream Cheese');

INSERT INTO Pizza_Ingredientes (idIngredientes, ID_Pizza) VALUES
(1, 1), (2, 1), (3, 1), (4, 1), (5, 1), (6, 1), (1, 2), (2, 2), (6, 2), (7, 2), (10, 2), (11, 2), (1, 3), (2, 3), (7, 3), (8, 3), (9, 3), (10, 3),
(1, 4), (2, 4), (3, 4), (5, 4), (8, 4), (12, 4), (1, 5), (2, 5), (6, 5), (8, 5), (10, 5), (11, 5), (1, 6), (2, 6), (6, 6), (8, 6), (9, 6), (1, 7), 
(2, 7), (4, 7), (5, 7), (6, 7), (13, 7), (1, 8), (2, 8), (3, 8), (5, 8), (7, 8), (13, 8), (1, 9), (2, 9), (4, 9), (5, 9), (8, 9), (13, 9), (1, 10), 
(2, 10), (3, 10), (5, 10), (6, 10), (13, 10), (1, 11), (2, 11), (4, 11), (5, 11), (9, 11), (13, 11), (1, 12), (2, 12), (3, 12), (5, 12), (10, 12), 
(13, 12), (1, 13), (2, 13), (4, 13), (5, 13), (11, 13), (13, 13), (1, 14), (2, 14), (3, 14), (5, 14), (12, 14), (13, 14), (1, 15), (2, 15), (20, 15), 
(21, 15), (29, 15), (30, 15), (1, 16), (18, 16), (19, 16), (20, 16), (21, 16), (22, 16), (1, 17), (2, 17), (4, 17), (5, 17), (7, 17), (13, 17), (1, 18), 
(2, 18), (3, 18), (5, 18), (8, 18), (13, 18), (1, 19), (2, 19), (4, 19), (5, 19), (9, 19), (13, 19), (1, 20), (15, 20), (20, 20), (21, 20), (29, 20), (30, 20),
(1, 21), (2, 21), (4, 21), (5, 21), (10, 21), (13, 21), (1, 22), (2, 22), (4, 22), (5, 22), (23, 22), (13, 22),
(1, 23), (2, 23), (4, 23), (5, 23), (24, 23), (13, 23), (1, 24), (2, 24), (4, 24), (5, 24), (25, 24), (13, 24),
(1, 25), (2, 25), (4, 25), (5, 25), (26, 25), (13, 25), (1, 26), (2, 26), (4, 26), (5, 26), (6, 26), (13, 26),
(1, 27), (2, 27), (4, 27), (5, 27), (27, 27), (13, 27), (1, 28), (16, 28), (17, 28), (27, 28), (28, 28), (13, 28),
(1, 29), (2, 29), (4, 29), (5, 29), (29, 29), (30, 29);


INSERT INTO Pizza (sabor, preco, descricao, tamanho, material_embalagem, preco_embalagem, tamanho_embalagem, ID_Receita) VALUES
('Pizza de Calabresa', 30.00, 'Pizza com calabresa, cebola, molho de tomate e queijo mozzarella.', 'Grande', 'Papelão', 2.50, '40x40', 1),
('Pizza Margherita', 35.00, 'Pizza com molho de tomate, queijo mozzarella, tomate e manjericão fresco.', 'Grande', 'Papelão', 2.50, '40x40', 2),
('Pizza Quatro Queijos', 40.00, 'Pizza com molho de tomate, queijo mozzarella, provolone, gorgonzola e parmesão.', 'Grande', 'Papelão', 2.50, '40x40', 3),
('Pizza Portuguesa', 38.00, 'Pizza com molho de tomate, queijo mozzarella, presunto, ovos, cebola, pimentão e azeitonas.', 'Grande', 'Papelão', 2.50, '40x40', 4),
('Pizza Frango com Catupiry', 42.00, 'Pizza com molho de tomate, queijo mozzarella, frango desfiado e catupiry.', 'Grande', 'Papelão', 2.50, '40x40', 5),
('Pizza Pepperoni', 36.00, 'Pizza com molho de tomate, queijo mozzarella e pepperoni fatiado.', 'Grande', 'Papelão', 2.50, '40x40', 6),
('Pizza Vegetariana', 39.00, 'Pizza com molho de tomate, queijo mozzarella, pimentão, cebola, tomate, azeitonas e cogumelos.', 'Grande', 'Papelão', 2.50, '40x40', 7),
('Pizza Supreme', 45.00, 'Pizza com molho de tomate, queijo mozzarella, presunto, calabresa, pimentão, cebola, tomate e azeitonas.', 'Grande', 'Papelão', 2.50, '40x40', 8),
('Pizza Bacon', 41.00, 'Pizza com molho de tomate, queijo mozzarella, bacon, cebola e parmesão.', 'Grande', 'Papelão', 2.50, '40x40', 9),
('Pizza Napolitana', 37.00, 'Pizza com molho de tomate, queijo mozzarella, tomate e azeitonas.', 'Grande', 'Papelão', 2.50, '40x40', 10),
('Pizza Caprese', 34.00, 'Pizza com molho de tomate, queijo mozzarella, tomate, manjericão fresco e parmesão.', 'Grande', 'Papelão', 2.50, '40x40', 11),
('Pizza Rúcula com Tomate Seco', 40.00, 'Pizza com molho de tomate, queijo mozzarella, rúcula, tomate seco e parmesão.', 'Grande', 'Papelão', 2.50, '40x40', 12),
('Pizza Alho e Óleo', 33.00, 'Pizza com molho de tomate, queijo mozzarella, alho frito e azeite.', 'Grande', 'Papelão', 2.50, '40x40', 13),
('Pizza Atum', 37.00, 'Pizza com molho de tomate, queijo mozzarella, atum, cebola e azeitonas.', 'Grande', 'Papelão', 2.50, '40x40', 14),
('Pizza Chocolate', 32.00, 'Pizza doce com chocolate ao leite derretido.', 'Grande', 'Papelão', 2.50, '40x40', 15),
('Pizza Banana com Canela', 30.00, 'Pizza doce com banana e canela.', 'Grande', 'Papelão', 2.50, '40x40', 16),
('Pizza Calabresa Especial', 38.00, 'Pizza com calabresa, cebola, molho de tomate, queijo mozzarella e azeitonas.', 'Grande', 'Papelão', 2.50, '40x40', 17),
('Pizza Frango Frito', 39.00, 'Pizza com molho de tomate, queijo mozzarella, frango empanado e parmesão.', 'Grande', 'Papelão', 2.50, '40x40', 18),
('Pizza Quatro Estações', 42.00, 'Pizza com molho de tomate, queijo mozzarella, presunto, palmito, champignon e azeitonas.', 'Grande', 'Papelão', 2.50, '40x40', 19),
('Pizza Doce de Leite', 34.00, 'Pizza doce com doce de leite e queijo mozzarella.', 'Grande', 'Papelão', 2.50, '40x40', 20),
('Pizza Morango com Chocolate', 36.00, 'Pizza doce com morango, chocolate ao leite e queijo mozzarella.', 'Grande', 'Papelão', 2.50, '40x40', 21),
('Pizza Mexicana', 40.00, 'Pizza com molho de tomate, queijo mozzarella, carne moída, pimentão, cebola, tomate, pimenta mexicana e azeitonas.', 'Grande', 'Papelão', 2.50, '40x40', 22),
('Pizza Pesto', 35.00, 'Pizza com molho pesto, queijo mozzarella, tomate e manjericão fresco.', 'Grande', 'Papelão', 2.50, '40x40', 23),
('Pizza Alcachofra', 38.00, 'Pizza com molho de tomate, queijo mozzarella, alcachofra, parmesão e azeitonas.', 'Grande', 'Papelão', 2.50, '40x40', 24),
('Pizza Filé Mignon', 42.00, 'Pizza com molho de tomate, queijo mozzarella, filé mignon, champignon e parmesão.', 'Grande', 'Papelão', 2.50, '40x40', 25),
('Pizza Vegana', 39.00, 'Pizza sem ingredientes de origem animal, com molho de tomate, queijo vegano, pimentão, cebola, tomate, azeitonas e cogumelos.', 'Grande', 'Papelão', 2.50, '40x40', 26),
('Pizza Lombinho Canadense', 44.00, 'Pizza com molho de tomate, queijo mozzarella, lombinho canadense, cebola e parmesão.', 'Grande', 'Papelão', 2.50, '40x40', 27),
('Pizza Dois Amores', 37.00, 'Pizza metade chocolate ao leite, metade chocolate branco.', 'Grande', 'Papelão', 2.50, '40x40', 28),
('Pizza Margherita Especial', 38.00, 'Pizza com molho de tomate, queijo mozzarella, tomate, manjericão fresco e parmesão.', 'Grande', 'Papelão', 2.50, '40x40', 29);



INSERT INTO Pizza_Pizzaiolo (ID_Pizza, idPizzaiolo) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15),
(16, 16),
(17, 17),
(18, 18),
(19, 19),
(20, 20),
(21, 21),
(22, 22),
(23, 23),
(24, 24),
(25, 25),
(26, 26),
(27, 27),
(28, 28),
(29, 29),
(30, 30);


/* Crie um relatório com todas as pizzas e os pizzaiolos aptos a produzi-las; */
select p.sabor AS 'Nome da Pizza', pz.nome AS 'Nome do Pizzaiolo Especializado' from Pizza p inner join Pizzaiolo pz on pz.especialidade = p.sabor;

/* Crie um relatório com todas as pizzas e seus ingredientes; */

SELECT p.ID_Pizza, p.sabor, i.nome_ingrediente
FROM Pizza p
INNER JOIN Pizza_Ingredientes pi ON p.ID_Pizza = pi.ID_Pizza
INNER JOIN Ingredientes i ON pi.idIngredientes = i.idIngredientes;

/* Crie um relatório com os sabores de todas as pizzas, o nome dos pizzaiolos que as fazem e as instruções para produzi-las; */

SELECT p.sabor AS 'Sabor da Pizza', pz.nome AS 'Nome Pizzaiolo', r.instrucoes AS 'Instruções'
FROM Pizza p
INNER JOIN Pizza_Pizzaiolo pp ON p.ID_Pizza = pp.ID_Pizza
INNER JOIN Pizzaiolo pz ON pp.idPizzaiolo = pz.idPizzaiolo
INNER JOIN receita r on r.ID_Receita  = p.ID_Receita;

    

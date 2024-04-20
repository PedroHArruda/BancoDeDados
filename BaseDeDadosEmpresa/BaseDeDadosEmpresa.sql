create table marcas(
	mrc_id int auto_increment,
	mrc_nome varchar(50) not null,
	mrc_nacionalidade varchar(50),
	primary key(mrc_id)
);

create table produtos(
	prd_id int auto_increment,
	prd_nome varchar(50) not null,
	prd_qtd_estoque int not null default 0,
	prd_estoque_mim int not null default 0,
	prd_data_fabricacao timestamp default now(),
	prd_perecivel boolean,
	prd_valor decimal(10,2),
	prd_marca_id int,
    prd_data_validade date,
	primary key(prd_id),
	foreign key(prd_marca_id) references marcas(mrc_id)
);



create table fornecedores(
	frn_id int auto_increment,
	frn_nome varchar(50) not null,
	frn_email varchar(50),
	primary key(frn_id)
);

create table produto_fornecedor(
	pf_prod_id int,
	pf_forn_id int,
	foreign key (pf_prod_id) references produtos(prd_id),
	foreign key (pf_forn_id) references fornecedores(frn_id),
	primary key (pf_prod_id, pf_forn_id)
);
INSERT INTO marcas (mrc_nome, mrc_nacionalidade) VALUES
('Nestlé', 'Suíça'),
('Sadia', 'Brasil'),
('Heinz', 'Estados Unidos'),
('Danone', 'França'),
('Gorton''s', 'Estados Unidos'),
('Kraft', 'Estados Unidos'),
('Frigorífico XYZ', 'Brasil'),
('Maçãs do Sul', 'Brasil'),
('Ovos de Ouro', 'Brasil'),
('Wursthaus', 'Alemanha'),
('Camil', 'Brasil'),
('Feijão do Sítio', 'Brasil'),
('Azeite Bella', 'Itália'),
('Barilla', 'Itália'),
('Lebreton', 'França'),
('Farinha Nacional', 'Brasil'),
('Lavazza', 'Itália'),
('Lindt', 'Suíça'),
('Twinings', 'Reino Unido'),
('Borges', 'Espanha');



-- Inserir dados na tabela produtos

INSERT INTO produtos (prd_nome, prd_qtd_estoque, prd_estoque_mim, prd_perecivel, prd_valor, prd_marca_id, prd_data_validade) VALUES
('Leite', 100, 20, true, 3.50, 1, '2023-12-31'),
('Frango', 50, 10, true, 8.99, 2, '2023-04-15'),
('Molho de Tomate', 75, 15, true, 1.25, 3, '2023-04-10'),
('Iogurte', 80, 10, true, 2.75, 4, '2023-05-20'),
('Peixe', 30, 5, true, 12.50, 5, '2023-03-28'),
('Queijo', 10, 2, true, 5.99, 6, '2022-12-31'),
('Carne Moída', 20, 5, true, 7.50, 6, '2022-11-15'),
('Maçã', 40, 10, true, 1.99, 8, '2022-10-20'),
('Ovos', 60, 15, true, 4.25, 9, '2022-09-12'),
('Salsicha', 25, 5, true, 6.75, 10, '2022-08-28'),
('Arroz', 200, 50, false, 5.99, 11, NULL),
('Feijão', 150, 30, false, 4.50, 12, NULL),
('Azeite', 100, 20, false, 9.75, 13, NULL),
('Macarrão', 120, 25, false, 3.25, 14, NULL),
('Sal', 50, 10, false, 1.99, 15, NULL),
('Farinha de Trigo', 80, 16, false, 2.50, 15, NULL),
('Café', 90, 20, false, 8.50, 17, NULL),
('Chocolate', 70, 12, false, 6.99, 18, NULL),
('Chá', 110, 25, false, 3.75, 19, NULL),
('Vinagre', 30, 5, false, 4.25, 20, NULL);

-- Inserir dados na tabela fornecedores
INSERT INTO fornecedores (frn_nome, frn_email) VALUES
('Distribuidora ABC', 'contato@abc.com'),
('Fornecedor XYZ', 'info@xyz.com'),
('Atacado 123', 'vendas@atacado123.com'),
('Suprimentos Total', 'suporte@suprimentos.com'),
('Comércio Rápido', 'compras@comerciorapido.com'),
('Entrega Garantida', 'entrega@garantida.com'),
('Atacado Bom Preço', 'vendas@atacadobompreco.com'),
('Fornecimento Direto', 'fornecimento@direto.com'),
('Importadora Global', 'info@importadoraglobal.com'),
('Atacado Qualidade', 'contato@atacadoqualidade.com'),
('Suprimentos Essenciais', 'suporte@essenciais.com'),
('Fornecedor Confiável', 'info@confiavel.com'),
('Distribuidora Alfa', 'vendas@alfa.com'),
('Comércio Eficiente', 'compras@eficiente.com'),
('Logística Ágil', 'entrega@agil.com');

-- Inserir dados na tabela produto_fornecedor
INSERT INTO produto_fornecedor (pf_prod_id, pf_forn_id) VALUES
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
(15, 1);

-- Crie uma view que mostra todos os produtos e suas respectivas marcas;
CREATE VIEW Produtos_Marcas AS
SELECT prd_nome AS "Nome do Produto", prd_id AS "ID do Produto", mrc_nome AS "Nome da Marca" FROM produtos INNER JOIN marcas ON prd_marca_id = mrc_id;

SELECT * FROM Produtos_Marcas;

-- Crie uma view que mostra todos os produtos e seus respectivos fornecedores;
CREATE VIEW Produtos_Fornecedores AS
SELECT pf_prod_id AS "ID do Produto", prd_nome AS "Nome do Produto", frn_nome AS "Nome do Fornecedor"
FROM produto_fornecedor
INNER JOIN produtos ON pf_prod_id = prd_id
INNER JOIN fornecedores ON pf_forn_id = frn_id;

SELECT * FROM Produtos_Fornecedores;

-- Crie uma view que mostra todos os produtos e seus respectivos fornecedores e marcas;
CREATE VIEW Produtos_Fornecedores_Marcas AS	
SELECT pf_prod_id AS "ID do Produto", prd_nome AS Produto, frn_nome AS Fornecedor, mrc_nome AS Marca
FROM produto_fornecedor
INNER JOIN produtos ON pf_prod_id = prd_id
INNER JOIN fornecedores ON pf_forn_id = frn_id
INNER JOIN marcas ON prd_marca_id = mrc_id;

SELECT * FROM Produtos_Fornecedores_Marcas;

-- Crie uma view que mostra todos os produtos com estoque abaixo do mínimo;
CREATE VIEW Produtos_Estoque AS
SELECT prd_id, prd_nome, prd_qtd_estoque, prd_estoque_mim FROM produtos WHERE prd_qtd_estoque < prd_estoque_mim;

SELECT * FROM Produtos_Estoque;

-- Crie uma view que mostra todos os produtos e suas respectivas marcas com validade vencida;
CREATE VIEW Produto_Validade_Vencida AS
SELECT prd_id AS "ID do Produto", prd_nome AS Produto, mrc_nome AS Marca, prd_data_validade AS "Marca de Validade" 
FROM produtos
INNER JOIN marcas ON prd_marca_id = mrc_id
WHERE prd_data_validade < CURDATE(); 

SELECT * FROM Produto_Validade_Vencida;

-- Selecionar os produtos com preço acima da média.
CREATE VIEW Produtos_Acima_Media AS
SELECT prd_id AS "ID do Produto", prd_nome AS Produto, prd_valor AS "Valor do Produto" FROM produtos WHERE prd_valor > (SELECT AVG(prd_valor) FROM produtos);

SELECT * FROM Produtos_Acima_Media;
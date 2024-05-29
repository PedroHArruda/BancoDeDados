-- Criação da base de dados
create schema locadoraveiculos;

-- Criação da tabela cliente
create table cliente (
    cod_cliente int auto_increment primary key,
    cpf varchar(11) not null,
    nome varchar(100) not null,
    nascimento date not null
);

-- Criação da tabela veiculo
create table veiculo (
    cod_veiculo int auto_increment primary key,
    veiculo varchar(100) not null,
    cor varchar(50) not null,
    placa varchar(7) not null,
    diaria double not null
);

-- Criação da tabela locacao
create table locacao (
    cod_locacao int auto_increment primary key,
    cod_veiculo int not null,
    cod_cliente int not null,
    dias int not null,
    total double,
    foreign key (cod_veiculo) references veiculo(cod_veiculo),
    foreign key (cod_cliente) references cliente(cod_cliente)
);

-- Trigger para calcular o valor da coluna total na tabela locacao

DELIMITER //

create trigger calcular_total_locacao
before insert on locacao
for each row
begin
    declare v_diaria double;
    select diaria into v_diaria from veiculo where cod_veiculo = new.cod_veiculo;
    set new.total = new.dias * v_diaria;
end//

DELIMITER ;

-- View para selecionar todas as locações com seus respectivos veículos e clientes

create view view_locacoes as
select 
l.cod_locacao,
    l.dias,
    l.total,
    c.nome as nome_cliente,
    c.cpf,
    v.veiculo,
    v.placa
from 
    locacao l
join 
    cliente c on l.cod_cliente = c.cod_cliente
join 
    veiculo v on l.cod_veiculo = v.cod_veiculo;

-- Inserção de dados para teste

insert into cliente (cpf, nome, nascimento) values 
('12345678901', 'João Silva', '1980-01-01'),
('23456789012', 'Maria Santos', '1990-02-02'),
('34567890123', 'Pedro Oliveira', '1985-03-03'),
('45678901234', 'Ana Costa', '1975-04-04'),
('56789012345', 'Carlos Souza', '1988-05-05'),
('67890123456', 'Paula Lima', '1992-06-06'),
('78901234567', 'Marcos Rocha', '1983-07-07'),
('89012345678', 'Fernanda Alves', '1995-08-08'),
('90123456789', 'Lucas Pereira', '1998-09-09'),
('01234567890', 'Juliana Ribeiro', '2000-10-10');

-- Inserts na tabela veiculo
insert into veiculo (veiculo, cor, placa, diaria) values 
('Fiat Uno', 'Branco', 'ABC1234', 50.0),
('Volkswagen Gol', 'Preto', 'DEF5678', 60.0),
('Chevrolet Onix', 'Vermelho', 'GHI9101', 70.0),
('Ford Ka', 'Prata', 'JKL2345', 55.0),
('Hyundai HB20', 'Azul', 'MNO6789', 65.0),
('Toyota Corolla', 'Cinza', 'PQR3456', 80.0),
('Honda Civic', 'Verde', 'STU9012', 75.0),
('Renault Sandero', 'Amarelo', 'VWX7890', 55.0),
('Peugeot 208', 'Laranja', 'YZA4567', 60.0),
('Nissan March', 'Roxo', 'BCD3456', 50.0);

-- Inserts na tabela locacao
insert into locacao (cod_veiculo, cod_cliente, dias) values (1, 1, 5),
(2, 2, 3),
(3, 3, 7),
(4, 4, 2),
(5, 5, 4),
(6, 6, 6),
(7, 7, 1),
(8, 8, 3),
(9, 9, 2),
(10, 10, 5);

-- Comando para chamar a view
select * from view_locacoes;
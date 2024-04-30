create table Pedidos (
	IDPedido int auto_increment,
    DataPedido datetime,
    NomeCliente varchar(100),
    primary key (IDPedido)
);

insert into	Pedidos(DataPedido, NomeCliente) values
(now(), "Cliente 1"),
(now(), "Cliente 1"),
(now(), "Cliente 1");

-- Criação da Trigger 

delimiter $
create trigger RegistroDataCriacaoPedido
before insert on Pedidos
for each row
begin
	set NEW.DataPedido = now();
end;
$ 
delimiter ;

insert into Pedidos (NomeCliente) values ('Novo Cliente1');
select * from Pedidos;

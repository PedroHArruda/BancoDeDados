
-- Trigger Exemplo 2

create table Filmes(
	id int auto_increment,
    titulo varchar(60),
    minutos int,
    primary key (id)
);

delimiter $
	create trigger chk_minutos before insert on Filmes
	for each row
	begin
		if new.minutos < 0 then
		set new.minutos = null;
		end if;
	end$

delimiter ;

insert into Filmes (titulo, minutos) values ("The Terrible Trigger", 120);
insert into Filmes (titulo, minutos) values ("O alto da compadecida", 135);
insert into Filmes (titulo, minutos) values ("Faroeste caboclo", 240);
insert into Filmes (titulo, minutos) values ("The matrix", 90);
insert into Filmes (titulo, minutos) values ("Blade runner", -88);
insert into Filmes (titulo, minutos) values ("O labirinto do fauno", 110);
insert into Filmes (titulo, minutos) values ("Metropole", 0);
insert into Filmes (titulo, minutos) values ("A lista", 120);


select * from Filmes;

delimiter $
	create trigger chk_minutos before insert on Filmes
    for each row
    begin
		if new.minutos < 0 then
			 signal sqlstate "45000"
             set message_text = "Valor inválido para minutos",
             mysql_errno = 2022;
		end if;
	end$
delimiter ;

create table Log_deletions (
	id int auto_increment,
    titulo varchar(60),
    quando datetime,
    quem varchar(40),
    primary key (id)
);

delimiter $ 
	create trigger log_deletions after delete on Filmes
		for each row
        begin 
			insert into Log_deletions values(null, old.titulo, sysdate(), user());
        end$
delimiter ;

delete from Filmes where id = 2;
delete from Filmes where id = 4;

select * from Log_deletions;


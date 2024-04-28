CREATE SCHEMA Universidade;

CREATE TABLE Cursos (
  Nome VARCHAR(50) NOT NULL,
  IDCurso INT NOT NULL auto_increment,
  PRIMARY KEY (IDCurso)
  );


CREATE TABLE Alunos(
  RA INT NOT NULL AUTO_INCREMENT,
  Nome VARCHAR(30),
  Sobrenome VARCHAR(30),
  Email VARCHAR(45),
  Cursos_IDCurso INT NOT NULL,
  PRIMARY KEY (RA),
  FOREIGN KEY (Cursos_IDCurso) REFERENCES Cursos(IDCurso)
   );

CREATE TABLE Professores(
  idProfessores INT NOT NULL auto_increment,
  Nome VARCHAR(100),
  Email VARCHAR(60),
  PRIMARY KEY (idProfessores)
  );


CREATE TABLE Cursos_Professores(
  Cursos_IDCurso INT NOT NULL,
  Professores_idProfessores INT NOT NULL,
  PRIMARY KEY (`Cursos_IDCurso`, `Professores_idProfessores`),
  FOREIGN KEY (Cursos_IDCurso) REFERENCES Cursos(IDCurso),
  FOREIGN KEY (Professores_idProfessores) REFERENCES Professores (idProfessores)
);

/* PROCEDURES PARA INSERÇÃO DOS DADOS */

delimiter $
create procedure novoAluno(
	Nome_p varchar(30),
    Sobrenome_p varchar(30),
    curso_p varchar(40)
)
begin
	declare numero_resultados int;
    
    set @IDCurso = (select IDCurso from Cursos where nome = curso_p);
    
    select count(*) into numero_resultados from Alunos where email = concat(Nome_p,'.',sobrenome_p);
    if numero_resultados > 0 then
		set @prefixo_email = concat(nome_p,'.',Sobrenome_p,Alunos.RA,'@dominio.com');
    else
		set @prefixo_email = concat(Nome_p,'.',Sobrenome_p,'@dominio.com');
	end if; 
    insert into Alunos (Nome, Sobrenome, Email, Cursos_IDCurso) VALUES (Nome_p, Sobrenome_p, @prefixo_email, @IDcurso);
    end$
delimiter ;

delimiter $
create procedure novoCurso(
	NomeCurso varchar(50)
)
begin 	
		insert into Cursos (Nome) values (NomeCurso);
end$
delimiter ;

delimiter $
create procedure novoProfessor(
	NomeProfessor varchar(100),
    EmailProfessor varchar(60)
)
	begin 
    insert into Professores (Nome, Email) values (NomeProfessor, EmailProfessor);
    end$
delimiter ;

delimiter $
create procedure novoCursoProfessor(
	IDCurso_p int,
    IDProfessor_p int
)
	begin 
    insert into Cursos_Professores (Cursos_IDCurso, Professores_idProfessores) values (IDCurso_p, IDProfessor_p);
    end$
delimiter ;  
    
call novoCurso("Análise e Desenvolvimento de Sistemas");
call novoCurso("Gestão de TI");
CALL novoCurso('Medicina');
CALL novoCurso('Engenharia Civil');
CALL novoCurso('Direito');
CALL novoCurso('Administração');
CALL novoCurso('Ciência da Computação');
CALL novoCurso('Arquitetura');
CALL novoCurso('Psicologia');
CALL novoCurso('Economia');
CALL novoCurso('Biologia');
CALL novoCurso('Educação Física');
CALL novoCurso('Gestão de TI');
CALL novoCurso('Engenharia de Software');

call novoAluno("Pedro", "Arruda", "Gestão de TI");
CALL novoAluno('João', 'Silva', 'Medicina');
CALL novoAluno('Maria', 'Santos', 'Engenharia Civil');
CALL novoAluno('Pedro', 'Oliveira', 'Direito');
CALL novoAluno('Ana', 'Martins', 'Administração');
CALL novoAluno('Lucas', 'Fernandes', 'Ciência da Computação');
CALL novoAluno('Camila', 'Pereira', 'Arquitetura');
CALL novoAluno('Carlos', 'Lima', 'Psicologia');
CALL novoAluno('Juliana', 'Gomes', 'Economia');
CALL novoAluno('Gabriel', 'Rodrigues', 'Biologia');
CALL novoAluno('Mariana', 'Almeida', 'Educação Física');
CALL novoAluno('Rafael', 'Costa', 'Medicina');
CALL novoAluno('Amanda', 'Ribeiro', 'Engenharia Civil');
CALL novoAluno('Mateus', 'Souza', 'Direito');
CALL novoAluno('Laura', 'Ferreira', 'Administração');
CALL novoAluno('Guilherme', 'Nunes', 'Ciência da Computação');
CALL novoAluno('Bianca', 'Mendes', 'Arquitetura');
CALL novoAluno('Luisa', 'Carvalho', 'Psicologia');
CALL novoAluno('Diego', 'Pinto', 'Economia');
CALL novoAluno('Carolina', 'Santana', 'Biologia');
CALL novoAluno('Vinicius', 'Cunha', 'Educação Física');
CALL novoAluno('Fernanda', 'Oliveira', 'Engenharia Civil');
CALL novoAluno('Rafael', 'Silva', 'Direito');
CALL novoAluno('Paula', 'Martins', 'Administração');
CALL novoAluno('Fernando', 'Oliveira', 'Ciência da Computação');
CALL novoAluno('Rafael', 'Silva', 'Arquitetura');

CALL novoProfessor('Pedro Rodrigues', 'pedro.rodrigues@example.com');
CALL novoProfessor('Ana Silva', 'ana.silva@example.com');
CALL novoProfessor('Carlos Oliveira', 'carlos.oliveira@example.com');
CALL novoProfessor('Juliana Santos', 'juliana.santos@example.com');
CALL novoProfessor('Gabriel Lima', 'gabriel.lima@example.com');
CALL novoProfessor('Mariana Costa', 'mariana.costa@example.com');
CALL novoProfessor('Lucas Fernandes', 'lucas.fernandes@example.com');
CALL novoProfessor('Amanda Pereira', 'amanda.pereira@example.com');
CALL novoProfessor('Laura Almeida', 'laura.almeida@example.com');
CALL novoProfessor('Thiago Mendes', 'thiago.mendes@example.com');
CALL novoProfessor('Bruna Oliveira', 'bruna.oliveira@example.com');
CALL novoProfessor('Diego Silva', 'diego.silva@example.com');
CALL novoProfessor('Julia Souza', 'julia.souza@example.com');
CALL novoProfessor('Marcos Santos', 'marcos.santos@example.com');
CALL novoProfessor('Fernanda Costa', 'fernanda.costa@example.com');

CALL novoCursoProfessor(1, 1);
CALL novoCursoProfessor(2, 2);
CALL novoCursoProfessor(3, 3);
CALL novoCursoProfessor(4, 4);
CALL novoCursoProfessor(5, 5);
CALL novoCursoProfessor(6, 6);
CALL novoCursoProfessor(7, 7);
CALL novoCursoProfessor(8, 8);
CALL novoCursoProfessor(9, 9);
CALL novoCursoProfessor(10, 10);
CALL novoCursoProfessor(11, 11);
CALL novoCursoProfessor(12, 12);
CALL novoCursoProfessor(13, 13);
CALL novoCursoProfessor(14, 14);
CALL novoCursoProfessor(15, 15);

/* PROCEDURES PARA SELEÇÃO DOS DADOS */

delimiter $ 
create procedure selecionarCursos()
begin 
	select * from Cursos;
end$

delimiter ;

delimiter $ 
create procedure selecionarAlunos()
begin 
	select * from Alunos;
end$

delimiter ;

delimiter $ 
create procedure selecionarProfessores()
begin 
	select * from Professores;
end$

delimiter ;

delimiter $ 
create procedure selecionarProfessoresECursos()
begin 
	select p.Nome as NomeProfessor, c.Nome as NomeCurso from professores p inner join Cursos_Professores on p.idProfessores = Professores_idProfessores 
    inner join Cursos c on Cursos_IDCurso = c.IDCurso;
end$

delimiter ;

call selecionarProfessoresECursos();
call selecionarAlunos();
call selecionarProfessores();
call selecionarCursos();

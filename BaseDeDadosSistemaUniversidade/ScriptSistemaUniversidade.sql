-- Criação da base de dados
create schema sistemauniversidade;

-- Criação da tabela area
create table area (
    cod_area int auto_increment,
    nome varchar(100) not null,
    primary key (cod_area)
);

-- Criação da tabela curso
create table curso (
    cod_curso int auto_increment,
    nome varchar(100) not null,
    cod_area int not null,
    foreign key (cod_area) references area(cod_area),
    primary key(cod_curso)
);

-- Criação da tabela aluno
create table aluno (
    ra int auto_increment,
    nome varchar(100) not null,
    sobrenome varchar(100) not null,
    data_nascimento date not null,
    cpf varchar(11) not null,
    email varchar(150) unique not null,
    cod_curso int not null,
    foreign key (cod_curso) references curso(cod_curso),
    primary key(ra)
);

-- Função para gerar e-mails
delimiter //
create function gerar_email(nome varchar(100), sobrenome varchar(100)) returns varchar(150)
begin
    declare email_base varchar(150);
    declare email_final varchar(150);
    declare email_existe int default 1;
    declare count_email int default 0;

    set email_base = concat(
        lower(trim(substring_index(nome, ' ', 1))), '.',
        lower(trim(substring_index(sobrenome, ' ', -1)))
    );

    while email_existe = 1 do
        if count_email = 0 then
            set email_final = concat(email_base, '@facens.com');
        else
            set email_final = concat(email_base, count_email, '@facens.com');
        end if;

        select count(*) into email_existe from aluno where email = email_final;
        set count_email = count_email + 1;
    end while;

    return email_final;
end //
delimiter ;


-- Função para retornar o ID de um curso pelo nome
delimiter //
create function obter_curso_id(curso_nome varchar(100)) returns int
begin
    declare v_cod_curso int;
    select cod_curso into v_cod_curso from curso where nome = curso_nome;
    return v_cod_curso;
end //
delimiter ;


-- Procedure para matricular um aluno
delimiter //
create procedure matricular_aluno(
    in aluno_nome varchar(100),
    in aluno_sobrenome varchar(100),
    in aluno_data_nascimento date,
    in aluno_cpf varchar(11),
    in curso_nome varchar(100)
)
begin
    declare v_cod_curso int;
    declare v_email varchar(150);
    declare aluno_existe int;

    set v_cod_curso = obter_curso_id(curso_nome);

    -- Verifica se o aluno já existe na base de dados
    select count(*) into aluno_existe from aluno 
    where cpf = aluno_cpf;

    if aluno_existe > 0 then
        signal sqlstate '45000' set message_text = 'aluno já matriculado em um curso';
    else
        -- Gera o e-mail único para o aluno
        set v_email = gerar_email(aluno_nome, aluno_sobrenome);

        insert into aluno (nome, sobrenome, data_nascimento, cpf, email, cod_curso)
        values (aluno_nome, aluno_sobrenome, aluno_data_nascimento, aluno_cpf, v_email, v_cod_curso);
    end if;
end //
delimiter ;

-- Procedure para adicionar área 

delimiter //
create procedure adicionar_area(in area_nome varchar(100))
begin
    -- Verifica se a área já existe
    if not exists (select * from area where nome = area_nome) then
        -- Insere a nova área
        insert into area (nome) values (area_nome);
    else
        signal sqlstate '45000' set message_text = 'Área já existe';
    end if;
end //
delimiter ;

-- Procedure para adicionar curso

delimiter //
create procedure adicionar_curso(in curso_nome varchar(100), in area_nome varchar(100))
begin
    declare v_cod_area int;

    -- Verifica se a área já existe, se não existir, insere uma nova área
    select cod_area into v_cod_area from area where nome = area_nome;
    if v_cod_area is null then
        insert into area (nome) values (area_nome);
        set v_cod_area = last_insert_id();
    end if;

    -- Verifica se o curso já existe
    if not exists (select * from curso where nome = curso_nome) then
        -- Insere o novo curso com o código da área
        insert into curso (nome, cod_area) values (curso_nome, v_cod_area);
    else
        signal sqlstate '45000' set message_text = 'Curso já existe';
    end if;
end //
delimiter ;

-- Procedure para selecionar todos as áreas
delimiter //
create procedure selecionar_areas()
begin
    select a.cod_area, a.nome as area_nome
    from area a;
end //
delimiter ;



-- Procedure para selecionar todos os cursos 
delimiter //
create procedure selecionar_cursos()
begin
    select c.cod_curso, c.nome as curso_nome, a.nome as area_nome
    from curso c
    inner join area a on c.cod_area = a.cod_area;
end //
delimiter ;

-- Procedure para selecionar todos os alunos
delimiter //
create procedure selecionar_alunos()
begin
    select al.ra, al.nome as aluno_nome, al.sobrenome, al.data_nascimento, al.cpf, al.email, c.nome as curso_nome, a.nome as area_nome
    from aluno al
    inner join curso c on al.cod_curso = c.cod_curso
    inner join area a on c.cod_area = a.cod_area;
end //
delimiter ;

-- Procedure para selecionar todos os alunos de determinado curso
delimiter //
create procedure selecionar_alunos_curso(
    in curso_nome varchar(100)
)
begin
    select al.ra, al.nome as aluno_nome, al.sobrenome, al.data_nascimento, al.cpf, al.email
    from aluno al
    inner join curso c on al.cod_curso = c.cod_curso
    where c.nome = curso_nome;
end //
delimiter ;


-- Procedure para selecionar todos os cursos de determinada área
delimiter //
create procedure selecionar_cursos_area(
    in area_nome varchar(100)
)
begin
    select c.cod_curso, c.nome as curso_nome
    from curso c
    inner join area a on c.cod_area = a.cod_area
    where a.nome = area_nome;
end //
delimiter ;

-- Procedure para selecionar todos os alunos matriculados em cursos de determinada área
delimiter //
create procedure selecionar_alunos_area(
    in area_nome varchar(100)
)
begin
    select al.ra, al.nome as aluno_nome, al.sobrenome, al.data_nascimento, al.cpf, al.email, c.nome as curso_nome
    from aluno al
    inner join curso c on al.cod_curso = c.cod_curso
    inner join area a on c.cod_area = a.cod_area
    where a.nome = area_nome;
end //
delimiter ;

-- Inserções de dados

-- Inserções de áreas
call adicionar_area('Saúde');
call adicionar_area('Engenharia');
call adicionar_area('Ciências Humanas e Sociais');
call adicionar_area('Ciências Exatas');

-- Inserções de cursos
call adicionar_curso('Medicina', 'Saúde');
call adicionar_curso('Enfermagem', 'Saúde');
call adicionar_curso('Fisioterapia', 'Saúde');
call adicionar_curso('Odontologia', 'Saúde');
call adicionar_curso('Biomedicina', 'Saúde');

call adicionar_curso('Engenharia da Computação', 'Engenharia');
call adicionar_curso('Engenharia Ambiental', 'Engenharia');
call adicionar_curso('Engenharia Civil', 'Engenharia');
call adicionar_curso('Engenharia Elétrica', 'Engenharia');
call adicionar_curso('Engenharia Mecânica', 'Engenharia');
call adicionar_curso('Engenharia de Produção', 'Engenharia');
call adicionar_curso('Engenharia Química', 'Engenharia');
call adicionar_curso('Engenharia de Materiais', 'Engenharia');
call adicionar_curso('Engenharia de Alimentos', 'Engenharia');
call adicionar_curso('Engenharia de Controle e Automação', 'Engenharia');

call adicionar_curso('Direito', 'Ciências Humanas e Sociais');
call adicionar_curso('História', 'Ciências Humanas e Sociais');
call adicionar_curso('Geografia', 'Ciências Humanas e Sociais');
call adicionar_curso('Administração', 'Ciências Humanas e Sociais');
call adicionar_curso('Economia', 'Ciências Humanas e Sociais');
call adicionar_curso('Publicidade e Propaganda', 'Ciências Humanas e Sociais');
call adicionar_curso('Relações Internacionais', 'Ciências Humanas e Sociais');
call adicionar_curso('Arquitetura', 'Ciências Humanas e Sociais');
call adicionar_curso('Filosofia', 'Ciências Humanas e Sociais');
call adicionar_curso('Sociologia', 'Ciências Humanas e Sociais');

-- Inserção de dados para a tabela aluno

-- Inserção curso de medicina 
call matricular_aluno('João', 'Silva', '2000-01-01', '12345678901', 'Medicina');
call matricular_aluno('Maria', 'Santos', '2001-02-03', '23456789012', 'Medicina');
call matricular_aluno('Carlos', 'Oliveira', '1999-05-15', '34567890123', 'Medicina');
call matricular_aluno('Ana', 'Pereira', '2002-08-20', '45678901234', 'Medicina');
call matricular_aluno('Pedro', 'Ferreira', '1998-11-30', '56789012345', 'Medicina');
call matricular_aluno('Julia', 'Gomes', '2003-04-10', '67890123456', 'Medicina');
call matricular_aluno('Lucas', 'Rodrigues', '1997-07-25', '78901234567', 'Medicina');
call matricular_aluno('Camila', 'Martins', '2004-09-05', '89012345678', 'Medicina');

-- Inserção curso de enfermagem
call matricular_aluno('José', 'Oliveira', '2000-03-15', '90123456789', 'Enfermagem');
call matricular_aluno('Mariana', 'Silveira', '1999-06-20', '01234567891', 'Enfermagem');
call matricular_aluno('Felipe', 'Santana', '1998-09-25', '12345678902', 'Enfermagem');
call matricular_aluno('Larissa', 'Pereira', '2001-12-30', '23456789013', 'Enfermagem');
call matricular_aluno('Rafael', 'Almeida', '1997-05-05', '34567890124', 'Enfermagem');
call matricular_aluno('Amanda', 'Gonçalves', '2002-07-10', '45678901235', 'Enfermagem');
call matricular_aluno('Bruno', 'Martinez', '1996-10-15', '56789012346', 'Enfermagem');
call matricular_aluno('Carolina', 'Ferreira', '2003-01-20', '67890123457', 'Enfermagem');

-- Inserção de curso de Fisioterapia 
call matricular_aluno('Lucas', 'Santos', '2000-02-15', '90123456780', 'Fisioterapia');
call matricular_aluno('Aline', 'Costa', '1999-05-20', '01234567892', 'Fisioterapia');
call matricular_aluno('Gustavo', 'Silva', '1998-08-25', '12345678903', 'Fisioterapia');
call matricular_aluno('Fernanda', 'Oliveira', '2001-11-30', '23456789014', 'Fisioterapia');
call matricular_aluno('Bruna', 'Martins', '1997-04-05', '34567890125', 'Fisioterapia');
call matricular_aluno('Ricardo', 'Gomes', '2002-06-10', '45678901236', 'Fisioterapia');
call matricular_aluno('Juliana', 'Rodrigues', '1996-09-15', '56789012347', 'Fisioterapia');
call matricular_aluno('Marcela', 'Ferreira', '2003-12-20', '67890123458', 'Fisioterapia');

-- Inserção curso de Odontologia
call matricular_aluno('Laura', 'Santos', '2000-02-15', '90123456781', 'Odontologia');
call matricular_aluno('Gabriel', 'Costa', '1999-05-20', '01234567893', 'Odontologia');
call matricular_aluno('Isabela', 'Silva', '1998-08-25', '12345678904', 'Odontologia');
call matricular_aluno('Ricardo', 'Oliveira', '2001-11-30', '23456789015', 'Odontologia');
call matricular_aluno('Natália', 'Martins', '1997-04-05', '34567890126', 'Odontologia');
call matricular_aluno('Fernando', 'Gomes', '2002-06-10', '45678901237', 'Odontologia');
call matricular_aluno('Vanessa', 'Rodrigues', '1996-09-15', '56789012348', 'Odontologia');
call matricular_aluno('Marcelo', 'Ferreira', '2003-12-20', '67890123459', 'Odontologia');

-- Inserção curso de Biomedicina
call matricular_aluno('Felipe', 'Silva', '2000-02-15', '90123456782', 'Biomedicina');
call matricular_aluno('Ana', 'Costa', '1999-05-20', '01234567894', 'Biomedicina');
call matricular_aluno('Luciana', 'Silveira', '1998-08-25', '12345678905', 'Biomedicina');
call matricular_aluno('Pedro', 'Oliveira', '2001-11-30', '23456789016', 'Biomedicina');
call matricular_aluno('Beatriz', 'Martins', '1997-04-05', '34567890127', 'Biomedicina');
call matricular_aluno('Vinícius', 'Gomes', '2002-06-10', '45678901238', 'Biomedicina');
call matricular_aluno('Carla', 'Rodrigues', '1996-09-15', '56789012349', 'Biomedicina');
call matricular_aluno('Matheus', 'Ferreira', '2003-12-20', '67890123460', 'Biomedicina');

-- Inserção curso de Engenharia da Computação
call matricular_aluno('Pedro', 'Silva', '2000-02-15', '90123456783', 'Engenharia da Computação');
call matricular_aluno('Camila', 'Costa', '1999-05-20', '01234567895', 'Engenharia da Computação');
call matricular_aluno('Gustavo', 'Silveira', '1998-08-25', '12345678906', 'Engenharia da Computação');
call matricular_aluno('Amanda', 'Oliveira', '2001-11-30', '23456789017', 'Engenharia da Computação');
call matricular_aluno('Lucas', 'Martins', '1997-04-05', '34567890128', 'Engenharia da Computação');
call matricular_aluno('Juliana', 'Gomes', '2002-06-10', '45678901239', 'Engenharia da Computação');
call matricular_aluno('Gabriel', 'Rodrigues', '1996-09-15', '56789012350', 'Engenharia da Computação');
call matricular_aluno('Carolina', 'Ferreira', '2003-12-20', '67890123461', 'Engenharia da Computação');

-- Inserção curso de Engenharia Ambiental
call matricular_aluno('Luana', 'Silva', '2000-02-15', '90123456784', 'Engenharia Ambiental');
call matricular_aluno('Guilherme', 'Costa', '1999-05-20', '01234567896', 'Engenharia Ambiental');
call matricular_aluno('Carolina', 'Silveira', '1998-08-25', '12345678907', 'Engenharia Ambiental');
call matricular_aluno('Matheus', 'Oliveira', '2001-11-30', '23456789018', 'Engenharia Ambiental');
call matricular_aluno('Patrícia', 'Martins', '1997-04-05', '34567890129', 'Engenharia Ambiental');
call matricular_aluno('Thiago', 'Gomes', '2002-06-10', '45678901240', 'Engenharia Ambiental');
call matricular_aluno('Isabela', 'Rodrigues', '1996-09-15', '56789012351', 'Engenharia Ambiental');
call matricular_aluno('Rafael', 'Ferreira', '2003-12-20', '67890123462', 'Engenharia Ambiental');

-- Inserção curso de Engenharia Civil
call matricular_aluno('Lucas', 'Silva', '2000-02-15', '90123456785', 'Engenharia Civil');
call matricular_aluno('Fernanda', 'Costa', '1999-05-20', '01234567897', 'Engenharia Civil');
call matricular_aluno('Rodrigo', 'Silveira', '1998-08-25', '12345678908', 'Engenharia Civil');
call matricular_aluno('Larissa', 'Oliveira', '2001-11-30', '23456789019', 'Engenharia Civil');
call matricular_aluno('Marcelo', 'Martins', '1997-04-05', '34567890130', 'Engenharia Civil');
call matricular_aluno('Jéssica', 'Gomes', '2002-06-10', '45678901241', 'Engenharia Civil');
call matricular_aluno('Diego', 'Rodrigues', '1996-09-15', '56789012352', 'Engenharia Civil');
call matricular_aluno('Vanessa', 'Ferreira', '2003-12-20', '67890123463', 'Engenharia Civil');

-- Inserção curso de Engenharia Elétrica
call matricular_aluno('Rafaela', 'Silva', '2000-02-15', '90123456786', 'Engenharia Elétrica');
call matricular_aluno('Bruno', 'Costa', '1999-05-20', '01234567898', 'Engenharia Elétrica');
call matricular_aluno('Juliano', 'Silveira', '1998-08-25', '12345678909', 'Engenharia Elétrica');
call matricular_aluno('Luiza', 'Oliveira', '2001-11-30', '23456789020', 'Engenharia Elétrica');
call matricular_aluno('Thiago', 'Martins', '1997-04-05', '34567890131', 'Engenharia Elétrica');
call matricular_aluno('Aline', 'Gomes', '2002-06-10', '45678901242', 'Engenharia Elétrica');
call matricular_aluno('Lucas', 'Rodrigues', '1996-09-15', '56789012353', 'Engenharia Elétrica');
call matricular_aluno('Gabriela', 'Ferreira', '2003-12-20', '67890123464', 'Engenharia Elétrica');

-- Inserção curso de Engenharia Mecânica
call matricular_aluno('Renato', 'Silva', '2000-02-15', '90123456787', 'Engenharia Mecânica');
call matricular_aluno('Natália', 'Costa', '1999-05-20', '01234567899', 'Engenharia Mecânica');
call matricular_aluno('Guilherme', 'Silveira', '1998-08-25', '12345678910', 'Engenharia Mecânica');
call matricular_aluno('Carla', 'Oliveira', '2001-11-30', '23456789021', 'Engenharia Mecânica');
call matricular_aluno('Mariana', 'Martins', '1997-04-05', '34567890132', 'Engenharia Mecânica');
call matricular_aluno('André', 'Gomes', '2002-06-10', '45678901243', 'Engenharia Mecânica');
call matricular_aluno('Amanda', 'Rodrigues', '1996-09-15', '56789012354', 'Engenharia Mecânica');
call matricular_aluno('Felipe', 'Ferreira', '2003-12-20', '67890123465', 'Engenharia Mecânica');

-- Inserção curso de Engenharia de Produção
call matricular_aluno('Rodrigo', 'Silva', '2000-02-15', '90123456788', 'Engenharia de Produção');
call matricular_aluno('Amanda', 'Costa', '1999-05-20', '01234567890', 'Engenharia de Produção');
call matricular_aluno('Pedro', 'Silveira', '1998-08-25', '12345678911', 'Engenharia de Produção');
call matricular_aluno('Beatriz', 'Oliveira', '2001-11-30', '23456789022', 'Engenharia de Produção');
call matricular_aluno('Lucas', 'Martins', '1997-04-05', '34567890133', 'Engenharia de Produção');
call matricular_aluno('Carolina', 'Gomes', '2002-06-10', '45678901244', 'Engenharia de Produção');
call matricular_aluno('André', 'Rodrigues', '1996-09-15', '56789012355', 'Engenharia de Produção');
call matricular_aluno('Juliana', 'Ferreira', '2003-12-20', '67890123466', 'Engenharia de Produção');

-- Inserção curso de Engenharia Química
call matricular_aluno('Ana', 'Silva', '2000-02-15', '91123456789', 'Engenharia Química');
call matricular_aluno('Paulo', 'Costa', '1999-05-20', '02234567890', 'Engenharia Química');
call matricular_aluno('Isabela', 'Silveira', '1998-08-25', '12345678912', 'Engenharia Química');
call matricular_aluno('João', 'Oliveira', '2001-11-30', '23456789023', 'Engenharia Química');
call matricular_aluno('Juliana', 'Martins', '1997-04-05', '34567890134', 'Engenharia Química');
call matricular_aluno('Lucas', 'Gomes', '2002-06-10', '45678901245', 'Engenharia Química');
call matricular_aluno('Maria', 'Rodrigues', '1996-09-15', '56789012356', 'Engenharia Química');
call matricular_aluno('Pedro', 'Ferreira', '2003-12-20', '67890123467', 'Engenharia Química');

-- Inserção no curso de Engenharia de Materiais 
call matricular_aluno('Marcela', 'Silva', '2000-02-15', '90123456790', 'Engenharia de Materiais');
call matricular_aluno('Felipe', 'Costa', '1999-05-20', '11234567892', 'Engenharia de Materiais');
call matricular_aluno('Carolina', 'Silveira', '1998-08-25', '12345678913', 'Engenharia de Materiais');
call matricular_aluno('Rafael', 'Oliveira', '2001-11-30', '23456789024', 'Engenharia de Materiais');
call matricular_aluno('Larissa', 'Martins', '1997-04-05', '34567890135', 'Engenharia de Materiais');
call matricular_aluno('Guilherme', 'Gomes', '2002-06-10', '45678901246', 'Engenharia de Materiais');
call matricular_aluno('Mariana', 'Rodrigues', '1996-09-15', '56789012357', 'Engenharia de Materiais');
call matricular_aluno('Lucas', 'Ferreira', '2003-12-20', '67890123468', 'Engenharia de Materiais');

-- Inserção no curso de Engenharia de Alimentos
call matricular_aluno('Thiago', 'Silva', '2000-02-15', '90123456791', 'Engenharia de Alimentos');
call matricular_aluno('Carolina', 'Costa', '1999-05-20', '11234567893', 'Engenharia de Alimentos');
call matricular_aluno('Guilherme', 'Silveira', '1998-08-25', '12345678914', 'Engenharia de Alimentos');
call matricular_aluno('Ana', 'Oliveira', '2001-11-30', '23456789025', 'Engenharia de Alimentos');
call matricular_aluno('Bruna', 'Martins', '1997-04-05', '34567890136', 'Engenharia de Alimentos');
call matricular_aluno('Pedro', 'Gomes', '2002-06-10', '45678901247', 'Engenharia de Alimentos');
call matricular_aluno('Mariana', 'Rodrigues', '1996-09-15', '56789012358', 'Engenharia de Alimentos');
call matricular_aluno('Lucas', 'Ferreira', '2003-12-20', '67890123469', 'Engenharia de Alimentos');

-- Inserção no curso de Engenharia de Controle e Automação
call matricular_aluno('Bruno', 'Silva', '2000-02-15', '90123456792', 'Engenharia de Controle e Automação');
call matricular_aluno('Juliana', 'Costa', '1999-05-20', '11234567894', 'Engenharia de Controle e Automação');
call matricular_aluno('Rodrigo', 'Silveira', '1998-08-25', '12345678915', 'Engenharia de Controle e Automação');
call matricular_aluno('Mariana', 'Oliveira', '2001-11-30', '23456789026', 'Engenharia de Controle e Automação');
call matricular_aluno('Lucas', 'Martins', '1997-04-05', '34567890137', 'Engenharia de Controle e Automação');
call matricular_aluno('Fernanda', 'Gomes', '2002-06-10', '45678901248', 'Engenharia de Controle e Automação');
call matricular_aluno('Gustavo', 'Rodrigues', '1996-09-15', '56789012359', 'Engenharia de Controle e Automação');
call matricular_aluno('Isabela', 'Ferreira', '2003-12-20', '67890123470', 'Engenharia de Controle e Automação');

-- Inserção no curso de Direito
call matricular_aluno('Ana', 'Silva', '2000-02-15', '90123456793', 'Direito');
call matricular_aluno('Pedro', 'Costa', '1999-05-20', '11234567895', 'Direito');
call matricular_aluno('Bruna', 'Silveira', '1998-08-25', '12345678916', 'Direito');
call matricular_aluno('Lucas', 'Oliveira', '2001-11-30', '23456789027', 'Direito');
call matricular_aluno('Mariana', 'Martins', '1997-04-05', '34567890138', 'Direito');
call matricular_aluno('Gustavo', 'Gomes', '2002-06-10', '45678901249', 'Direito');
call matricular_aluno('Juliana', 'Rodrigues', '1996-09-15', '56789012360', 'Direito');
call matricular_aluno('Felipe', 'Ferreira', '2003-12-20', '67890123471', 'Direito');

-- Inserção no curso de História
call matricular_aluno('Gabriela', 'Silva', '2000-02-15', '90123456794', 'História');
call matricular_aluno('Rafael', 'Costa', '1999-05-20', '11234567896', 'História');
call matricular_aluno('Aline', 'Silveira', '1998-08-25', '12345678917', 'História');
call matricular_aluno('Gustavo', 'Oliveira', '2001-11-30', '23456789028', 'História');
call matricular_aluno('Isabela', 'Martins', '1997-04-05', '34567890139', 'História');
call matricular_aluno('Lucas', 'Gomes', '2002-06-10', '45678901250', 'História');
call matricular_aluno('Juliana', 'Rodrigues', '1996-09-15', '56789012361', 'História');
call matricular_aluno('Pedro', 'Ferreira', '2003-12-20', '67890123472', 'História');

-- Inserção no curso de Geografia
call matricular_aluno('Carla', 'Silva', '2000-02-15', '90123456795', 'Geografia');
call matricular_aluno('Rodrigo', 'Costa', '1999-05-20', '11234567897', 'Geografia');
call matricular_aluno('Mariana', 'Silveira', '1998-08-25', '12345678918', 'Geografia');
call matricular_aluno('Lucas', 'Oliveira', '2001-11-30', '23456789029', 'Geografia');
call matricular_aluno('Bruna', 'Martins', '1997-04-05', '34567890140', 'Geografia');
call matricular_aluno('Gustavo', 'Gomes', '2002-06-10', '45678901251', 'Geografia');
call matricular_aluno('Ana', 'Rodrigues', '1996-09-15', '56789012362', 'Geografia');
call matricular_aluno('Pedro', 'Ferreira', '2003-12-20', '67890123473', 'Geografia');

-- Inserção no curso de Administração
call matricular_aluno('Mariana', 'Silva', '2000-02-15', '90123456796', 'Administração');
call matricular_aluno('Gabriel', 'Costa', '1999-05-20', '11234567898', 'Administração');
call matricular_aluno('Carolina', 'Silveira', '1998-08-25', '12345678919', 'Administração');
call matricular_aluno('Lucas', 'Oliveira', '2001-11-30', '23456789030', 'Administração');
call matricular_aluno('Fernanda', 'Martins', '1997-04-05', '34567890141', 'Administração');
call matricular_aluno('Pedro', 'Gomes', '2002-06-10', '45678901252', 'Administração');
call matricular_aluno('Juliana', 'Rodrigues', '1996-09-15', '56789012363', 'Administração');
call matricular_aluno('Gustavo', 'Ferreira', '2003-12-20', '67890123474', 'Administração');

-- Inserção no curso de Economia
call matricular_aluno('Rafael', 'Silva', '2000-02-15', '90123456797', 'Economia');
call matricular_aluno('Amanda', 'Costa', '1999-05-20', '11234567899', 'Economia');
call matricular_aluno('Lucas', 'Silveira', '1998-08-25', '12345678920', 'Economia');
call matricular_aluno('Carolina', 'Oliveira', '2001-11-30', '23456789031', 'Economia');
call matricular_aluno('Gabriel', 'Martins', '1997-04-05', '34567890142', 'Economia');
call matricular_aluno('Isabela', 'Gomes', '2002-06-10', '45678901253', 'Economia');
call matricular_aluno('Juliana', 'Rodrigues', '1996-09-15', '56789012364', 'Economia');
call matricular_aluno('Pedro', 'Ferreira', '2003-12-20', '67890123475', 'Economia');

-- Inserção no curso de Publicidade e Propaganda
call matricular_aluno('Fernanda', 'Silva', '2000-02-15', '90123456798', 'Publicidade e Propaganda');
call matricular_aluno('Bruno', 'Costa', '1999-05-20', '11234567900', 'Publicidade e Propaganda');
call matricular_aluno('Juliana', 'Silveira', '1998-08-25', '12345678921', 'Publicidade e Propaganda');
call matricular_aluno('Pedro', 'Oliveira', '2001-11-30', '23456789032', 'Publicidade e Propaganda');
call matricular_aluno('Mariana', 'Martins', '1997-04-05', '34567890143', 'Publicidade e Propaganda');
call matricular_aluno('Lucas', 'Gomes', '2002-06-10', '45678901254', 'Publicidade e Propaganda');
call matricular_aluno('Isabela', 'Rodrigues', '1996-09-15', '56789012365', 'Publicidade e Propaganda');
call matricular_aluno('Gustavo', 'Ferreira', '2003-12-20', '67890123476', 'Publicidade e Propaganda');

-- Inserção no curso de Relações Internacionais
call matricular_aluno('Ana', 'Silva', '2000-02-15', '90123456799', 'Relações Internacionais');
call matricular_aluno('Gabriel', 'Costa', '1999-05-20', '11234567901', 'Relações Internacionais');
call matricular_aluno('Carolina', 'Silveira', '1998-08-25', '12345678922', 'Relações Internacionais');
call matricular_aluno('Lucas', 'Oliveira', '2001-11-30', '23456789033', 'Relações Internacionais');
call matricular_aluno('Mariana', 'Martins', '1997-04-05', '34567890144', 'Relações Internacionais');
call matricular_aluno('Gustavo', 'Gomes', '2002-06-10', '45678901255', 'Relações Internacionais');
call matricular_aluno('Juliana', 'Rodrigues', '1996-09-15', '56789012366', 'Relações Internacionais');
call matricular_aluno('Pedro', 'Ferreira', '2003-12-20', '67890123477', 'Relações Internacionais');

-- Inserção no curso de Arquitetura
call matricular_aluno('Leonardo', 'Silva', '2000-02-15', '90123456800', 'Arquitetura');
call matricular_aluno('Marina', 'Costa', '1999-05-20', '11234567902', 'Arquitetura');
call matricular_aluno('Rafael', 'Silveira', '1998-08-25', '12345678923', 'Arquitetura');
call matricular_aluno('Carla', 'Oliveira', '2001-11-30', '23456789034', 'Arquitetura');
call matricular_aluno('Vinícius', 'Martins', '1997-04-05', '34567890145', 'Arquitetura');
call matricular_aluno('Fernanda', 'Gomes', '2002-06-10', '45678901256', 'Arquitetura');
call matricular_aluno('Pedro', 'Rodrigues', '1996-09-15', '56789012367', 'Arquitetura');
call matricular_aluno('Juliana', 'Ferreira', '2003-12-20', '67890123478', 'Arquitetura');

-- Inserção no curso de Filosofia
call matricular_aluno('Camila', 'Silva', '2000-02-15', '90123456801', 'Filosofia');
call matricular_aluno('Lucas', 'Costa', '1999-05-20', '11234567903', 'Filosofia');
call matricular_aluno('Gabriela', 'Silveira', '1998-08-25', '12345678924', 'Filosofia');
call matricular_aluno('Pedro', 'Oliveira', '2001-11-30', '23456789035', 'Filosofia');
call matricular_aluno('Marina', 'Martins', '1997-04-05', '34567890146', 'Filosofia');
call matricular_aluno('Rafael', 'Gomes', '2002-06-10', '45678901257', 'Filosofia');
call matricular_aluno('Fernanda', 'Rodrigues', '1996-09-15', '56789012368', 'Filosofia');
call matricular_aluno('Gustavo', 'Ferreira', '2003-12-20', '67890123479', 'Filosofia');

-- Inserção no curso de Sociologia
call matricular_aluno('Mariana', 'Silva', '2000-02-15', '90123456802', 'Sociologia');
call matricular_aluno('Bruno', 'Costa', '1999-05-20', '11234567904', 'Sociologia');
call matricular_aluno('Juliana', 'Silveira', '1998-08-25', '12345678925', 'Sociologia');
call matricular_aluno('Lucas', 'Oliveira', '2001-11-30', '23456789036', 'Sociologia');
call matricular_aluno('Isabela', 'Martins', '1997-04-05', '34567890147', 'Sociologia');
call matricular_aluno('Gustavo', 'Gomes', '2002-06-10', '45678901258', 'Sociologia');
call matricular_aluno('Carolina', 'Rodrigues', '1996-09-15', '56789012369', 'Sociologia');
call matricular_aluno('Pedro', 'Ferreira', '2003-12-20', '67890123480', 'Sociologia');

-- Testando funções e procedures
select obter_curso_id("Medicina");
select obter_curso_id("Sociologia"); 


call selecionar_areas();
call selecionar_cursos();
call selecionar_alunos();

call selecionar_alunos_curso('Arquitetura');
call selecionar_alunos_curso('Sociologia');
call selecionar_alunos_curso('História');

call selecionar_cursos_area('Saúde');
call selecionar_cursos_area('Engenharia');
call selecionar_cursos_area('Ciências Humanas e Sociais');
call selecionar_cursos_area('Ciências Exatas');

call selecionar_alunos_area('Saúde');
call selecionar_alunos_area('Engenharia');
call selecionar_alunos_area('Ciências Humanas e Sociais');
call selecionar_alunos_area('Ciências Exatas');
/* UPX II: */

CREATE TABLE Usuario (
    Nome VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL,
    data_comeco_fumo DATE NOT NULL,
    ID_User INTEGER AUTO_INCREMENT NOT NULL,
    Email VARCHAR (100) NOT NULL,
    Senha VARBINARY(255) NOT NULL,
    media_cigarro INTEGER NOT NULL,
    qtdDiasSemFumar INTEGER,
    qtdDiasVicio INTEGER,
    ContagemCigarros INTEGER,
    meta INTEGER NOT NULL,
    custo_diario DOUBLE(5,2) NOT NULL,
    nivel_dependencia INTEGER NOT NULL,
    primary key (ID_User)
);

INSERT INTO Usuario (Nome, data_nascimento, data_comeco_fumo, Email, Senha, media_cigarro, qtdDiasSemFumar, qtdDiasVicio, ContagemCigarros, meta, custo_diario, nivel_dependencia) VALUES
("Joao Almeida", "2000-01-01", "2018-04-01", "joaoalmeida@gmail.com", AES_ENCRYPT("abc123", 'minhachave'), 10, null, null, null, 1, 10.00, 8);

select * from Usuario;  

CREATE TABLE RegistroDiario (
    ID_RegistroDiario INTEGER AUTO_INCREMENT,
    nivel_desejo_fumar INTEGER NOT NULL,
    cigarros_fumados INTEGER NOT NULL,
    data_registro datetime DEFAULT current_timestamp() NOT NULL, 
    ID_User INTEGER NOT NULL,
    PRIMARY KEY (ID_RegistroDiario),
    FOREIGN KEY (ID_User) REFERENCES Usuario(ID_User)
);

INSERT INTO RegistroDiario (nivel_desejo_fumar, cigarros_fumados, ID_User) VALUES
(6, 10, 1);

INSERT INTO RegistroDiario (nivel_desejo_fumar, cigarros_fumados, data_registro, ID_User) VALUES
(6, 10, "2024-01-12", 1);

select * from RegistroDiario;
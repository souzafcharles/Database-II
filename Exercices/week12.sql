/*1. Conseidere as seguintes tabelas de um banco de dados relacional:

    CLiente(cod, nome, qtde_locacoes)
    Aluguel(nro, cod_cli, cod_filme, data_hora_emp, data_hora_dev)
    Filme(cod, titulo, classificacao, qtde_locacoes)*/
    
-- I - Crie as tabelas acima, definido tipo e constrains adequadas. Coloque o valor DEFAULT 0 para qdte_locacoes nas
-- tabelas e sysdate para data_hora_emp na tabela Aluguel.
-- II - Os atributos qtde_locacoes sao atributos derivados e devem ser atualizados por meio de triggers.
-- III - O valor do atrabuto data_hora_dev deve ser atualizado conforme a classificacao do filme - Lançamento (1dia)
-- ou Normal (2 dias). Desenvolva um gatilho para gerar corretamente este valor.
-- IV - Teste os gatilhos por meio de inserções de dados na tabela Aluguel. Consulte todas as tabelas para saber se funcionou.

CREATE TABLE CLIENTE (
    cod NUMBER(3),
    nome VARCHAR2(30),
    qtde_locacoes NUMBER(5) DEFAULT 0,
    CONSTRAINT CLIENTE_pk PRIMARY KEY(cod)
);

CREATE TABLE FILME (
    cod NUMBER(3),
    titulo VARCHAR2(30),
    classificacao VARCHAR2(20),
    qtde_locacoes NUMBER(5) DEFAULT 0,
    CONSTRAINT filme_pk PRIMARY KEY(cod)
);

CREATE TABLE ALUGUEL (
    nro NUMBER(6),
    cod_cli NUMBER(3),
    cod_filme NUMBER(3),
    data_hora_emp TIMESTAMP DEFAULT SYSDATE,
    data_hora_dev TIMESTAMP,
    CONSTRAINT aluguel_pk PRIMARY KEY(nro),
    CONSTRAINT aluguel_cli_fk FOREIGN KEY(cod_cli) REFERENCES CLIENTE(cod),
    CONSTRAINT aluguel_filme_fk FOREIGN KEY(cod_filme) REFERENCES filme(cod)
);

INSERT INTO CLIENTE(cod, nome) VALUES (1, 'Maria');
INSERT INTO CLIENTE(cod, nome) VALUES (2, 'Joao');
INSERT INTO filme(cod, titulo, classificacao) VALUES (10, 'X-Men', 'Normal');
INSERT INTO filme(cod, titulo, classificacao) VALUES (20, 'Capitao America', 'Lançamento');

CREATE OR REPLACE TRIGGER tr_aluguel
    BEFORE INSERT ON aluguel
    FOR EACH ROW
DECLARE
    v_class filme.classificacao%TYPE;
BEGIN
    SELECT classificacao INTO v_class
        FROM filme WHERE cod = :new.cod_filme;

    UPDATE CLIENTE SET qtde_locacoes = qtde_locacoes + 1
        WHERE cod = :new.cod_cli;

    UPDATE filme SET qtde_locacoes = qtde_locacoes + 1
        WHERE cod = :new.cod_filme;

    IF v_class = 'Lançamento' THEN
        :new.data_hora_dev := :new.data_hora_emp + 1;
    ELSE
        :new.data_hora_dev := :new.data_hora_emp + 2;
    END IF;
END tr_aluguel;

INSERT INTO ALUGUEL(nro, cod_cli, cod_filme) VALUES (1,1,10);
SELECT * FROM CLIENTE;
SELECT * FROM FILME;
SELECT * FROM ALUGUEL;

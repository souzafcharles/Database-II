-- CHARLES:
-- Criar as tabelas de acordo com o Modelo Relacional, indicando as devidas PKs, FKs e demais constraints, se houver:

CREATE TABLE PREFEITURA (
 id             NUMBER(4) NOT NULL,
 cidade 	    VARCHAR2(50) NOT NULL,
 website 	    VARCHAR2(100),
 email    	    VARCHAR2(80),
 telefone 	    VARCHAR2(20),
 data_inicio 	DATE NOT NULL,
 data_fim 	    DATE,
 CONSTRAINT prefeitura_pk PRIMARY KEY (id)
);

CREATE TABLE SECRETARIA (
 codigo         NUMBER(6) NOT NULL,
 nome 		    VARCHAR2(50) NOT NULL,
 email    	    VARCHAR2(80),
 telefone 	    VARCHAR2(20),
 id_prefeitura 	NUMBER(4), 
 CONSTRAINT secretaria_pk PRIMARY KEY (codigo),
 CONSTRAINT secretaria_prefeitura_fk FOREIGN KEY (id_prefeitura) REFERENCES prefeitura(id)
);

CREATE TABLE SERVIDORPUBLICO (
 matricula          NUMBER(10) NOT NULL,
 nome 			    VARCHAR2(50) NOT NULL,
 cpf                VARCHAR2(14) NOT NULL,
 sexo 			    CHAR(1), 
 salario 		    NUMBER(10,2) NOT NULL, 
 telefone 		    VARCHAR2(20), 
 email 			    VARCHAR2(80), 
 escolaridade 	    VARCHAR2(10), 
 funcao 		    VARCHAR2(50) NOT NULL, 
 codigo_secretaria 	NUMBER(6), 
 CONSTRAINT servidorpublico_pk PRIMARY KEY (matricula),
 CONSTRAINT servidorpublico_uk UNIQUE (cpf),
 CONSTRAINT servidorpublico_ck CHECK (sexo IN ('M','F','m','f')),
 CONSTRAINT servidorpublico_salario_ck CHECK (salario > 0),
 CONSTRAINT servidor_secretaria_fk FOREIGN KEY (codigo_secretaria) REFERENCES secretaria(codigo)
);

CREATE TABLE FUNCIONARIOPUBLICO (
 matricula_servidorpublico 	NUMBER(10),
 gratificacao 			    CHAR(1) DEFAULT 'N',
 CONSTRAINT funcionariopublico_pk PRIMARY KEY (matricula_servidorpublico),
 CONSTRAINT funcionariopublico_incentivo_ck CHECK(gratificacao IN ('S','s','N','n')),
 CONSTRAINT funcionariopublico_atleta_fk FOREIGN KEY (matricula_servidorpublico) REFERENCES servidorpublico(matricula)
);

CREATE TABLE FUNCIONARIOTEMPORARIO (
 matricula_servidorpublico 	NUMBER(10),
 comissionado 			    CHAR(1),
 data_inicio 			    DATE NOT NULL,
 data_fim 			        DATE,
 CONSTRAINT funcionariotemporario_pk PRIMARY KEY (matricula_servidorpublico),
 CONSTRAINT funcionariotemporario_incentivo_ck CHECK(comissionado IN ('S','s','N','n')),
 CONSTRAINT funcionariotemporario_atleta_fk FOREIGN KEY (matricula_servidorpublico) REFERENCES servidorpublico(matricula)
);

CREATE TABLE EVENTO (
 numero 		    NUMBER(10),
 nome 			    VARCHAR2(70) NOT NULL,
 local 			    VARCHAR2(70),
 custo 			    NUMBER(10,2) NOT NULL,
 data_inicio 		DATE,
 data_fim 		    DATE,
 codigo_secretaria 	NUMBER(6), 
 CONSTRAINT evento_pk PRIMARY KEY (numero),
 CONSTRAINT servidorpublico_custo_ck CHECK (custo > 0),
 CONSTRAINT evento_secretaria_fk FOREIGN KEY (codigo_secretaria) REFERENCES secretaria(codigo)
);

CREATE TABLE PLANEJA (
 matricula_servidorpublico 	NUMBER(10),
 numero_evento 			    NUMBER(10),
 horas 				        NUMBER(6,2),
 CONSTRAINT planeja_pk PRIMARY KEY (matricula_servidorpublico, numero_evento),
 CONSTRAINT planeja_servidorpublico_fk FOREIGN KEY(matricula_servidorpublico) REFERENCES servidorpublico(matricula),
 CONSTRAINT planeja_evento_fk FOREIGN KEY(numero_evento) REFERENCES evento(numero)
);

-- Criacao das Sequences:
CREATE SEQUENCE prefeitura_sequence INCREMENT BY 1 START WITH 1 MAXVALUE 9999 NOCYCLE NOCACHE;
CREATE SEQUENCE secretaria_sequence INCREMENT BY 2 START WITH 1000 MAXVALUE 999999 NOCYCLE NOCACHE;
CREATE SEQUENCE servidor_sequence INCREMENT BY 3 START WITH 100 MAXVALUE 9999999999 NOCYCLE NOCACHE;
CREATE SEQUENCE evento_sequence INCREMENT BY 4 START WITH 50 MAXVALUE 9999999999 NOCYCLE NOCACHE;

/*
DROP SEQUENCE prefeitura_sequence;
DROP SEQUENCE secretaria_sequence;
DROP SEQUENCE servidor_sequence;
DROP SEQUENCE evento_sequence;
*/

-- Insercao de dados PREFEITURA:
INSERT INTO  PREFEITURA (id, cidade, website, email, telefone, data_inicio, data_fim) VALUES (prefeitura_sequence.nextval, 'Boa Vista', 'https://boavista.rr.gov.br', 'prefeitura@boavista.rr.gov.br', '(95) 3621-3333', to_date('01/01/2005','dd/mm/yyyy'), to_date('31/12/2008','dd/mm/yyyy'));
INSERT INTO  PREFEITURA (id, cidade, website, email, telefone, data_inicio, data_fim) VALUES (prefeitura_sequence.nextval, 'Rorainopolis', 'https://rorainopolis.rr.gov.br', 'prefeitura@rorainopolis.rr.gov.br', '(95) 3321-2121', to_date('01/01/2005','dd/mm/yyyy'), to_date('31/12/2008','dd/mm/yyyy'));
INSERT INTO  PREFEITURA (id, cidade, website, email, telefone, data_inicio, data_fim) VALUES (prefeitura_sequence.nextval, 'Caracarai', 'https://caracarai.rr.gov.br', 'prefeitura@caracarai.rr.gov.br', '(95) 3221-5569', to_date('01/01/2005','dd/mm/yyyy'), to_date('31/12/2008','dd/mm/yyyy'));
INSERT INTO  PREFEITURA (id, cidade, website, email, telefone, data_inicio, data_fim) VALUES (prefeitura_sequence.nextval, 'Pacaraima', 'https://pacaraima.rr.gov.br', 'prefeitura@pacaraima.rr.gov.br', '(95) 3521-6987', to_date('01/01/2005','dd/mm/yyyy'), to_date('31/12/2008','dd/mm/yyyy'));
INSERT INTO  PREFEITURA (id, cidade, website, email, telefone, data_inicio, data_fim) VALUES (prefeitura_sequence.nextval, 'Canta', 'https://canta.rr.gov.br', 'prefeitura@canta.rr.gov.br', '(95) 3721-2229', to_date('01/01/2005','dd/mm/yyyy'), to_date('31/12/2008','dd/mm/yyyy'));
INSERT INTO  PREFEITURA (id, cidade, website, email, telefone, data_inicio, data_fim) VALUES (prefeitura_sequence.nextval, 'Mucajai', 'https://mucajai.rr.gov.br', 'prefeitura@mucajai.rr.gov.br', '(95) 3821-1002', to_date('01/01/2005','dd/mm/yyyy'), to_date('31/12/2008','dd/mm/yyyy'));
INSERT INTO  PREFEITURA (id, cidade, website, email, telefone, data_inicio, data_fim) VALUES (prefeitura_sequence.nextval, 'Alto Alegre', 'https://altoalegre.rr.gov.br', 'prefeitura@altoalegre.rr.gov.br', '(95) 3621-0001', to_date('01/01/2005','dd/mm/yyyy'), to_date('31/12/2008','dd/mm/yyyy'));
INSERT INTO  PREFEITURA (id, cidade, website, email, telefone, data_inicio, data_fim) VALUES (prefeitura_sequence.nextval, 'Amajari', 'https://amajari.rr.gov.br', 'prefeitura@amajari.rr.gov.br', '(95) 3921-9635', to_date('01/01/2005','dd/mm/yyyy'), to_date('31/12/2008','dd/mm/yyyy'));
INSERT INTO  PREFEITURA (id, cidade, website, email, telefone, data_inicio, data_fim) VALUES (prefeitura_sequence.nextval, 'Bonfim', 'https://bonfim.rr.gov.br', 'prefeitura@bonfim.rr.gov.br', '(95) 3333-1800', to_date('01/01/2005','dd/mm/yyyy'), to_date('31/12/2008','dd/mm/yyyy'));
INSERT INTO  PREFEITURA (id, cidade, website, email, telefone, data_inicio, data_fim) VALUES (prefeitura_sequence.nextval, 'Iracema', 'https://iracema.rr.gov.br', 'prefeitura@iracema.rr.gov.br', '(95) 3126-1500', to_date('01/01/2005','dd/mm/yyyy'), to_date('31/12/2008','dd/mm/yyyy'));
INSERT INTO  PREFEITURA (id, cidade, website, email, telefone, data_inicio, data_fim) VALUES (prefeitura_sequence.nextval, 'Normandia', 'https://normandia.rr.gov.br', 'prefeitura@normandia.rr.gov.br', '(95) 3111-1799', to_date('01/01/2005','dd/mm/yyyy'), to_date('31/12/2008','dd/mm/yyyy'));
INSERT INTO  PREFEITURA (id, cidade, website, email, telefone, data_inicio, data_fim) VALUES (prefeitura_sequence.nextval, 'Uiramutao', 'https://uiramuta.rr.gov.br', 'prefeitura@uiramuta.rr.gov.br', '(95) 3222-1654', to_date('01/01/2005','dd/mm/yyyy'), to_date('31/12/2008','dd/mm/yyyy'));
INSERT INTO  PREFEITURA (id, cidade, website, email, telefone, data_inicio, data_fim) VALUES (prefeitura_sequence.nextval, 'Caroebe', 'https://caroebe.rr.gov.br', 'prefeitura@caroebe.rr.gov.br', '(95) 3899-7412', to_date('01/01/2005','dd/mm/yyyy'), to_date('31/12/2008','dd/mm/yyyy'));
INSERT INTO  PREFEITURA (id, cidade, website, email, telefone, data_inicio, data_fim) VALUES (prefeitura_sequence.nextval, 'Sao Joao da Baliza', 'https://saojoaodabaliza.rr.gov.br', 'prefeitura@saojoaodabaliza.rr.gov.br', '(95) 3187-3020', to_date('01/01/2005','dd/mm/yyyy'), to_date('31/12/2008','dd/mm/yyyy'));
INSERT INTO  PREFEITURA (id, cidade, website, email, telefone, data_inicio, data_fim) VALUES (prefeitura_sequence.nextval, 'Sao Luiz', 'https://saoluiz.rr.gov.br', 'prefeitura@saoluiz.rr.gov.br', '(95) 3622-8523', to_date('01/01/2005','dd/mm/yyyy'), to_date('31/12/2008','dd/mm/yyyy'));
INSERT INTO  PREFEITURA (id, cidade, website, email, telefone, data_inicio, data_fim) VALUES (prefeitura_sequence.nextval, 'Boa Vista', 'https://boavista.rr.gov.br', 'prefeitura@boavista.rr.gov.br', '(95) 3621-3333', to_date('01/01/2009','dd/mm/yyyy'), to_date('31/12/2012','dd/mm/yyyy'));
INSERT INTO  PREFEITURA (id, cidade, website, email, telefone, data_inicio, data_fim) VALUES (prefeitura_sequence.nextval, 'MucajaiÂ­', 'https://mucajai.rr.gov.br', 'prefeitura@mucajai.rr.gov.br', '(95) 3821-1002', to_date('01/01/2009','dd/mm/yyyy'), to_date('31/12/2012','dd/mm/yyyy'));
INSERT INTO  PREFEITURA (id, cidade, website, email, telefone, data_inicio, data_fim) VALUES (prefeitura_sequence.nextval, 'Alto Alegre', 'https://altoalegre.rr.gov.br', 'prefeitura@altoalegre.rr.gov.br', '(95) 3621-0001', to_date('01/01/2009','dd/mm/yyyy'), to_date('31/12/2012','dd/mm/yyyy'));
INSERT INTO  PREFEITURA (id, cidade, website, email, telefone, data_inicio, data_fim) VALUES (prefeitura_sequence.nextval, 'Amajari', 'https://amajari.rr.gov.br', 'prefeitura@amajari.rr.gov.br', '(95) 3921-9635', to_date('01/01/2009','dd/mm/yyyy'), to_date('31/12/2012','dd/mm/yyyy'));
INSERT INTO  PREFEITURA (id, cidade, website, email, telefone, data_inicio, data_fim) VALUES (prefeitura_sequence.nextval, 'Bonfim', 'https://bonfim.rr.gov.br', 'prefeitura@bonfim.rr.gov.br', '(95) 3333-1800', to_date('01/01/2009','dd/mm/yyyy'), to_date('31/12/2012','dd/mm/yyyy'));
INSERT INTO  PREFEITURA (id, cidade, website, email, telefone, data_inicio, data_fim) VALUES (prefeitura_sequence.nextval, 'Boa Vista', 'https://boavista.rr.gov.br', 'prefeitura@boavista.rr.gov.br', '(95) 3621-3333', to_date('01/01/2013','dd/mm/yyyy'), to_date('31/12/2016','dd/mm/yyyy'));
INSERT INTO  PREFEITURA (id, cidade, website, email, telefone, data_inicio, data_fim) VALUES (prefeitura_sequence.nextval, 'Rorainopolis', 'https://rorainopolis.rr.gov.br', 'prefeitura@rorainopolis.rr.gov.br', '(95) 3321-2121', to_date('01/01/2013','dd/mm/yyyy'), to_date('31/12/2016','dd/mm/yyyy'));
INSERT INTO  PREFEITURA (id, cidade, website, email, telefone, data_inicio, data_fim) VALUES (prefeitura_sequence.nextval, 'Caracarai', 'https://caracarai.rr.gov.br', 'prefeitura@caracarai.rr.gov.br', '(95) 3221-5569', to_date('01/01/2013','dd/mm/yyyy'), to_date('31/12/2016','dd/mm/yyyy'));
INSERT INTO  PREFEITURA (id, cidade, website, email, telefone, data_inicio, data_fim) VALUES (prefeitura_sequence.nextval, 'Iracema', 'https://iracema.rr.gov.br', 'prefeitura@iracema.rr.gov.br', '(95) 3126-1500', to_date('01/01/2013','dd/mm/yyyy'), to_date('31/12/2016','dd/mm/yyyy'));
INSERT INTO  PREFEITURA (id, cidade, website, email, telefone, data_inicio, data_fim) VALUES (prefeitura_sequence.nextval, 'Normandia', 'https://normandia.rr.gov.br', 'prefeitura@normandia.rr.gov.br', '(95) 3111-1799', to_date('01/01/2013','dd/mm/yyyy'), to_date('31/12/2016','dd/mm/yyyy'));

-- Insercao  de dados SECRETARIA:
INSERT INTO  SECRETARIA (codigo, nome, email, telefone, id_prefeitura) VALUES (secretaria_sequence.nextval, 'Secretaria do Lazer e Turismo', 'secretarialt@caroebe.rr.gov.br', '(95) 3899-7412', 13);
INSERT INTO  SECRETARIA (codigo, nome, email, telefone, id_prefeitura) VALUES (secretaria_sequence.nextval, 'Secretaria da Educacao e Turismo', 'secretariaedutur@iracema.rr.gov.br', '(95) 3126-1589', 10);
INSERT INTO  SECRETARIA (codigo, nome, email, telefone, id_prefeitura) VALUES (secretaria_sequence.nextval, 'Secretaria de Cultura e Turismo', 'culturaturismo@canta.rr.gov.br', '(95) 3721-2233', 5);
INSERT INTO  SECRETARIA (codigo, nome, email, telefone, id_prefeitura) VALUES (secretaria_sequence.nextval, 'Secretaria de Desenvolvimento e Planejamento', 'secretarialt@pacaraima.rr.gov.br', '(95) 3521-6987', 4);
INSERT INTO  SECRETARIA (codigo, nome, email, telefone, id_prefeitura) VALUES (secretaria_sequence.nextval, 'Secretaria do Lazer e Turismo', 'secretarialt@saoluiz.rr.gov.br', '(95) 3622-8543', 15);
INSERT INTO  SECRETARIA (codigo, nome, email, telefone, id_prefeitura) VALUES (secretaria_sequence.nextval, 'Secretaria da Educacao, Cultura e Lazer', 'secretariaecl@bonfim.rr.gov.br', '(95) 3333-1800', 9);
INSERT INTO  SECRETARIA (codigo, nome, email, telefone, id_prefeitura) VALUES (secretaria_sequence.nextval, 'Secretaria de Turismo', 'turismo@mucajai.rr.gov.br', '(95) 3821-1555', 8);
INSERT INTO  SECRETARIA (codigo, nome, email, telefone, id_prefeitura) VALUES (secretaria_sequence.nextval, 'Secretaria da Cultura', 'cultura@altoalegre.rr.gov.br', '(95) 3621-0005', 18);
INSERT INTO  SECRETARIA (codigo, nome, email, telefone, id_prefeitura) VALUES (secretaria_sequence.nextval, 'Secretaria da Educacao e Cultura', 'educacaoecultura@altoalegre.rr.gov.br', '(95) 3621-0005', 7);
INSERT INTO  SECRETARIA (codigo, nome, email, telefone, id_prefeitura) VALUES (secretaria_sequence.nextval, 'Secretaria de Esporte', 'secretariaespoerte@caracarai.rr.gov.br', '(95) 3221-5569', 23);
INSERT INTO  SECRETARIA (codigo, nome, email, telefone, id_prefeitura) VALUES (secretaria_sequence.nextval, 'Secretaria da Educacao e Cultura', 'educultura@mucajai.rr.gov.br', '(95) 3821-1004', 6);
INSERT INTO  SECRETARIA (codigo, nome, email, telefone, id_prefeitura) VALUES (secretaria_sequence.nextval, 'Secretaria de Esporte', 'secretariaespoerte@caracarai.rr.gov.br', '(95) 3221-5569', 3);
INSERT INTO  SECRETARIA (codigo, nome, email, telefone, id_prefeitura) VALUES (secretaria_sequence.nextval, 'Secretaria da Cultura e Esporte', 'turismoesporte@rorainopolis.rr.gov.br', '(95) 3226-1018', 2);
INSERT INTO  SECRETARIA (codigo, nome, email, telefone, id_prefeitura) VALUES (secretaria_sequence.nextval, 'Secretaria de Desenvolvimento e Planejamento', 'secretariadp@normandia.rr.gov.br', '(95) 3126-1801', 11);
INSERT INTO  SECRETARIA (codigo, nome, email, telefone, id_prefeitura) VALUES (secretaria_sequence.nextval, 'Secretaria de Turismo', 'secretariaturismo@rorainopolis.rr.gov.br', '(95) 3226-1018', 22);
INSERT INTO  SECRETARIA (codigo, nome, email, telefone, id_prefeitura) VALUES (secretaria_sequence.nextval, 'Secretaria de Desenvolvimento e Planejamento', 'secretariadp@normandia.rr.gov.br', '(95) 3126-1801', 25);
INSERT INTO  SECRETARIA (codigo, nome, email, telefone, id_prefeitura) VALUES (secretaria_sequence.nextval, 'Secretaria de Turismo', 'turismo@iracema.rr.gov.br', '(95) 3289-2722', 24);
INSERT INTO  SECRETARIA (codigo, nome, email, telefone, id_prefeitura) VALUES (secretaria_sequence.nextval, 'Secretaria do Lazer e Turismo', 'secretarialt@bonfim.rr.gov.br', '(95) 3333-1800', 20);
INSERT INTO  SECRETARIA (codigo, nome, email, telefone, id_prefeitura) VALUES (secretaria_sequence.nextval, 'Secretaria da Educacao e Cultura', 'educultura@mucajai.rr.gov.br', '(95) 3821-1004', 17);
INSERT INTO  SECRETARIA (codigo, nome, email, telefone, id_prefeitura) VALUES (secretaria_sequence.nextval, 'Secretaria de Cultura e Turismo', 'culturaturismo@boavista.rr.gov.br', '(95) 3111-5555', 1);
INSERT INTO  SECRETARIA (codigo, nome, email, telefone, id_prefeitura) VALUES (secretaria_sequence.nextval, 'Secretaria da Cultura', 'culturaturismo@boavista.rr.gov.br', '(95) 3111-5555', 16);
INSERT INTO  SECRETARIA (codigo, nome, email, telefone, id_prefeitura) VALUES (secretaria_sequence.nextval, 'Secretaria de Eventos', 'eventos@boavista.rr.gov.br', '(95) 3111-5555', 21);
INSERT INTO  SECRETARIA (codigo, nome, email, telefone, id_prefeitura) VALUES (secretaria_sequence.nextval, 'Secretaria da Cultura', 'culturaturismo@uiramuta.rr.gov.br', '(95) 3785-5125', 12);
INSERT INTO  SECRETARIA (codigo, nome, email, telefone, id_prefeitura) VALUES (secretaria_sequence.nextval, 'Secretaria de Turismo', 'turismo@mucajai.rr.gov.br', '(95) 3821-1555', 19);

-- Insercao  de dados SERVIDORPUBLICO:                                                                                                                           
INSERT INTO  SERVIDORPUBLICO (matricula, nome, cpf, sexo, salario, telefone, email, escolaridade, funcao, codigo_secretaria) VALUES (servidor_sequence.nextval, 'Geremias Gomes', '391.153.062-02', 'M', 5767.30, '(95) 98239-7523', 'gomes@email.com', 'Nivel 4', 'Turismologo', 1000);
INSERT INTO  SERVIDORPUBLICO (matricula, nome, cpf, sexo, salario, telefone, email, escolaridade, funcao, codigo_secretaria) VALUES (servidor_sequence.nextval, 'Gumercindo Guerino', '002.157.132-78', 'M', 3782.40, '(95) 98240-3589', 'guerino@email.com', 'Nivel 4', 'Turismologo', 1002);
INSERT INTO  SERVIDORPUBLICO (matricula, nome, cpf, sexo, salario, telefone, email, escolaridade, funcao, codigo_secretaria) VALUES (servidor_sequence.nextval, 'Filomena Fiica Mendes', '952.741.062-96', 'F', 10767.25, '(95) 98241-7412', 'filomena@email.com', 'Nivel 5', 'Coordenador Turismologo', 1004);
INSERT INTO  SERVIDORPUBLICO (matricula, nome, cpf, sexo, salario, telefone, email, escolaridade, funcao, codigo_secretaria) VALUES (servidor_sequence.nextval, 'Crispim Epaminondas', '753.963.552-15', 'M', 6769.96, '(95) 98242-9523', 'epaminondas@email.com', 'Nivel 4', 'Turismologo', 1006);
INSERT INTO  SERVIDORPUBLICO (matricula, nome, cpf, sexo, salario, telefone, email, escolaridade, funcao, codigo_secretaria) VALUES (servidor_sequence.nextval, 'Moacir de Iracema Martin', '654.202.222-87', 'M', 3767.88, '(95) 98246-7896', 'moacir@email.com', 'Nivel 4', 'Turismologo', 1008);
INSERT INTO  SERVIDORPUBLICO (matricula, nome, cpf, sexo, salario, telefone, email, escolaridade, funcao, codigo_secretaria) VALUES (servidor_sequence.nextval, 'Giocaonda Giacomoni', '123.153.982-15', 'F', 5766.23, '(95) 98251-3205', 'giocaondagiacomoni@email.com', 'Nivel 4', 'Turismologo', 1010);
INSERT INTO  SERVIDORPUBLICO (matricula, nome, cpf, sexo, salario, telefone, email, escolaridade, funcao, codigo_secretaria) VALUES (servidor_sequence.nextval, 'Belizario Guerino', '321.153.252-00', 'M', 11787.12, '(95) 98296-8963', 'belizarioguerino@email.com', 'Nivel 5', 'Chefia em Turismo', 1038);
INSERT INTO  SERVIDORPUBLICO (matricula, nome, cpf, sexo, salario, telefone, email, escolaridade, funcao, codigo_secretaria) VALUES (servidor_sequence.nextval, 'Jenario Zimmer', '654.153.442-96', 'M', 2763.99, '(95) 98255-3265', 'belizarioguerino@email.com', 'Nivel 4', 'Turismologo', 1014);
INSERT INTO  SERVIDORPUBLICO (matricula, nome, cpf, sexo, salario, telefone, email, escolaridade, funcao, codigo_secretaria) VALUES (servidor_sequence.nextval, 'Eugenia Maria da Silva', '987.153.742-01', 'F', 9761.41, '(95) 98274-1025', 'eugenia@email.com', 'Nivel 5', 'Vicecoordenador Turismologo', 1016);
INSERT INTO  SERVIDORPUBLICO (matricula, nome, cpf, sexo, salario, telefone, email, escolaridade, funcao, codigo_secretaria) VALUES (servidor_sequence.nextval, 'Catarina Ivaneide dos Santos', '159.005.742-11', 'F', 5263.05, '(95) 98139-9632', 'cativaneide@email.com', 'Nivel 4', 'Turismologo', 1018);
INSERT INTO  SERVIDORPUBLICO (matricula, nome, cpf, sexo, salario, telefone, email, escolaridade, funcao, codigo_secretaria) VALUES (servidor_sequence.nextval, 'Celestina Pereira', '951.153.002-68', 'F', 5123.76, '(95) 98859-2636', 'celestina@email.com', 'Nivel 5', 'Turismologo', 1020);
INSERT INTO  SERVIDORPUBLICO (matricula, nome, cpf, sexo, salario, telefone, email, escolaridade, funcao, codigo_secretaria) VALUES (servidor_sequence.nextval, 'Lazaro Leontino', '218.173.002-71', 'M', 2123.76, '(95) 98811-1234', 'leontin@email.com', 'Nivel 4', 'Profissional de Educacao Fisica', 1022);
INSERT INTO  SERVIDORPUBLICO (matricula, nome, cpf, sexo, salario, telefone, email, escolaridade, funcao, codigo_secretaria) VALUES (servidor_sequence.nextval, 'Raimundo Marcomino', '197.153.002-96', 'M', 3123.05, '(95) 98859-3214', 'marcomino@email.com', 'Nivel 4', 'Profissional de Educacao Fisica', 1024);
INSERT INTO  SERVIDORPUBLICO (matricula, nome, cpf, sexo, salario, telefone, email, escolaridade, funcao, codigo_secretaria) VALUES (servidor_sequence.nextval, 'Sebastiao Militao', '961.189.002-47', 'M', 2123.04, '(95) 9223-7894', 'militao@email.com', 'Nivel 4', 'Profissional de Educacao Fisica', 1026);
INSERT INTO  SERVIDORPUBLICO (matricula, nome, cpf, sexo, salario, telefone, email, escolaridade, funcao, codigo_secretaria) VALUES (servidor_sequence.nextval, 'Amancio Nogueiras', '874.173.077-68', 'M', 3123.66, '(95) 93698-4987', 'amacionogueiras@email.com', 'Nivel 4', 'Profissional de Educacao Fisica', 1028);
INSERT INTO  SERVIDORPUBLICO (matricula, nome, cpf, sexo, salario, telefone, email, escolaridade, funcao, codigo_secretaria) VALUES (servidor_sequence.nextval, 'Jonival Jonas', '114.183.072-68', 'M', 2123.44, '(95) 99874-6398', 'jonivaljonas@email.com', 'Nivel 4', 'Profissional de Educacao Fisica', 1030);
INSERT INTO  SERVIDORPUBLICO (matricula, nome, cpf, sexo, salario, telefone, email, escolaridade, funcao, codigo_secretaria) VALUES (servidor_sequence.nextval, 'Marcolino Giribelo Pereira', '951.122.002-14', 'M', 9123.20, '(95) 99635-1597', 'marcolinogiribelo@email.com', 'Nivel 4', 'Chefia de Esportes', 1032);
INSERT INTO  SERVIDORPUBLICO (matricula, nome, cpf, sexo, salario, telefone, email, escolaridade, funcao, codigo_secretaria) VALUES (servidor_sequence.nextval, 'Gloria Bradao', '191.953.252-44', 'F', 2123.76, '(95) 97412-0023', 'gloriab@email.com', 'Nivel 4', 'Turismologo', 1034);
INSERT INTO  SERVIDORPUBLICO (matricula, nome, cpf, sexo, salario, telefone, email, escolaridade, funcao, codigo_secretaria) VALUES (servidor_sequence.nextval, 'Sibila Custodia Godoi', '391.153.152-02', 'F', 4767.30, '(95) 98239-9637', 'sibilacustodia@email.com', 'Nivel 5', 'Profissional de Educacao Fisica', 1036);
INSERT INTO  SERVIDORPUBLICO (matricula, nome, cpf, sexo, salario, telefone, email, escolaridade, funcao, codigo_secretaria) VALUES (servidor_sequence.nextval, 'Zuleide Zacarias', '002.183.062-02', 'F', 4767.30, '(95) 9963-5287', 'zuleidezacarias@email.com', 'Nivel 5', 'Profissional de Educacao Fisica', 1038);
INSERT INTO  SERVIDORPUBLICO (matricula, nome, cpf, sexo, salario, telefone, email, escolaridade, funcao, codigo_secretaria) VALUES (servidor_sequence.nextval, 'Benjamin Brito', '659.255.452-78', 'M', 500.15, '(95) 97418-1112', 'benjamin@email.com', 'Nivel 2', 'Jovem Aprendiz', 1040);
INSERT INTO  SERVIDORPUBLICO (matricula, nome, cpf, sexo, salario, telefone, email, escolaridade, funcao, codigo_secretaria) VALUES (servidor_sequence.nextval, 'Calisto Bello', '783.143.542-87', 'M', 650.51, '(95) 98412-1478', 'calisto@email.com', 'Nivel 2', 'Jovem Aprendiz', 1042);
INSERT INTO  SERVIDORPUBLICO (matricula, nome, cpf, sexo, salario, telefone, email, escolaridade, funcao, codigo_secretaria) VALUES (servidor_sequence.nextval, 'Balthazar Gregorio', '850.883.852-51', 'M', 780.45, '(95) 98485-8520', 'balthazargregorio@email.com', 'Nivel 3', 'Estagiario em Turismo', 1044);
INSERT INTO  SERVIDORPUBLICO (matricula, nome, cpf, sexo, salario, telefone, email, escolaridade, funcao, codigo_secretaria) VALUES (servidor_sequence.nextval, 'Vincentina Barbosa', '051.956.952-15', 'F', 760.54, '(95) 97415-9630', 'vincentina@email.com', 'Nivel 3', 'Estagiario em Educacao Fisica', 1046);
INSERT INTO  SERVIDORPUBLICO (matricula, nome, cpf, sexo, salario, telefone, email, escolaridade, funcao, codigo_secretaria) VALUES (servidor_sequence.nextval, 'Katia Elis Miguelito', '390.198.882-89', 'F', 860.54, '(95) 9968-5288', 'katia@email.com', 'Nivel 3', 'Estagiario em Educacao Fisica', 1038);
INSERT INTO  SERVIDORPUBLICO (matricula, nome, cpf, sexo, salario, telefone, email, escolaridade, funcao, codigo_secretaria) VALUES (servidor_sequence.nextval, 'Marlene Manuela Matos', '004.400.402-42', 'F', 4767.30, '(95) 9867-7787', 'lene@email.com', 'Nivel 5', 'Profissional de Educacao Fisica', 1038);
INSERT INTO  SERVIDORPUBLICO (matricula, nome, cpf, sexo, salario, telefone, email, escolaridade, funcao, codigo_secretaria) VALUES (servidor_sequence.nextval, 'Paulino Santos', '050.780.422-99', 'M', 4767.30, '(95) 8827-9999', 'santos@email.com', 'Nivel 5', 'Profissional de Educacao Fisica', 1038);
INSERT INTO  SERVIDORPUBLICO (matricula, nome, cpf, sexo, salario, telefone, email, escolaridade, funcao, codigo_secretaria) VALUES (servidor_sequence.nextval, 'Enrico Prado', '200.125.962-85', 'M', 5263.05, '(95) 9777-9696', 'prado@email.com', 'Nivel 4', 'Turismologo', 1038);
INSERT INTO  SERVIDORPUBLICO (matricula, nome, cpf, sexo, salario, telefone, email, escolaridade, funcao, codigo_secretaria) VALUES (servidor_sequence.nextval, 'Leonidas Braga', '024.025.242-17', 'M', 7263.05, '(95) 96565-1158', 'leonidas@email.com', 'Nivel 4', 'Advogado', 1026);
INSERT INTO  SERVIDORPUBLICO (matricula, nome, cpf, sexo, salario, telefone, email, escolaridade, funcao, codigo_secretaria) VALUES (servidor_sequence.nextval, 'Salvatore Valentin', '123.005.262-98', 'M', 15263.05, '(95) 9985-2288', 'salvatore@email.com', 'Nivel 4', 'Advogado', 1038);
INSERT INTO  SERVIDORPUBLICO (matricula, nome, cpf, sexo, salario, telefone, email, escolaridade, funcao, codigo_secretaria) VALUES (servidor_sequence.nextval, 'Ronildo Ramos', '789.078.212-02', 'M', 5263.05, '(95) 98369-9632', 'ronildo@email.com', 'Nivel 4', 'Turismologo', 1012);
INSERT INTO  SERVIDORPUBLICO (matricula, nome, cpf, sexo, salario, telefone, email, escolaridade, funcao, codigo_secretaria) VALUES (servidor_sequence.nextval, 'Rivaldo Sandro Diniz', '355.105.142-15', 'M', 7863.05, '(95) 98520-1478', 'diniz@email.com', 'Nivel 4', 'Advogado', 1014);
INSERT INTO  SERVIDORPUBLICO (matricula, nome, cpf, sexo, salario, telefone, email, escolaridade, funcao, codigo_secretaria) VALUES (servidor_sequence.nextval, 'Vincenzo Zanin', '852.205.842-25', 'M', 4863.05, '(95) 98520-1478', 'vincenzo@email.com', 'Nivel 4', 'Adminitrador', 1038);
INSERT INTO  SERVIDORPUBLICO (matricula, nome, cpf, sexo, salario, telefone, email, escolaridade, funcao, codigo_secretaria) VALUES (servidor_sequence.nextval, 'Sandra Mantovani', '632.198.142-19', 'F', 4863.05, '(95) 98520-1478', 'sandra@email.com', 'Nivel 4', 'Adminitrador', 1014);
INSERT INTO  SERVIDORPUBLICO (matricula, nome, cpf, sexo, salario, telefone, email, escolaridade, funcao, codigo_secretaria) VALUES (servidor_sequence.nextval, 'Clotilde Valencio', '556.112.842-85', 'F', 12863.05, '(95) 98520-1478', 'clotilde@email.com', 'Nivel 5', 'Adminitrador', 1038);
INSERT INTO  SERVIDORPUBLICO (matricula, nome, cpf, sexo, salario, telefone, email, escolaridade, funcao, codigo_secretaria) VALUES (servidor_sequence.nextval, 'Martin Bras', '114.105.113-74', 'M', 3785.05, '(95) 98520-1478', 'martinbras@email.com', 'Nivel 4', 'Adminitrador', 1014);
INSERT INTO  SERVIDORPUBLICO (matricula, nome, cpf, sexo, salario, telefone, email, escolaridade, funcao, codigo_secretaria) VALUES (servidor_sequence.nextval, 'Angelina Campos', '778.135.146-63', 'F', 3163.05, '(95) 98520-1478', 'angelina@email.com', 'Nivel 4', 'Adminitrador', 1014);
INSERT INTO  SERVIDORPUBLICO (matricula, nome, cpf, sexo, salario, telefone, email, escolaridade, funcao, codigo_secretaria) VALUES (servidor_sequence.nextval, 'Teodora Dias', '330.105.123-74', 'F', 2963.05, '(95) 98520-1478', 'teodora@email.com', 'Nivel 4', 'Adminitrador', 1010);
INSERT INTO  SERVIDORPUBLICO (matricula, nome, cpf, sexo, salario, telefone, email, escolaridade, funcao, codigo_secretaria) VALUES (servidor_sequence.nextval, 'Floriano Santos', '229.155.842-96', 'M', 2963.05, '(95) 98520-1478', 'floriano@email.com', 'Nivel 5', 'Adminitrador', 1008);
INSERT INTO  SERVIDORPUBLICO (matricula, nome, cpf, sexo, salario, telefone, email, escolaridade, funcao, codigo_secretaria) VALUES (servidor_sequence.nextval, 'Zacarias Pinto Neto', '578.105.142-74', 'M', 3263.05, '(95) 98520-1478', 'zacariasneto@email.com', 'Nivel 4', 'Adminitrador', 1016);
INSERT INTO  SERVIDORPUBLICO (matricula, nome, cpf, sexo, salario, telefone, email, escolaridade, funcao, codigo_secretaria) VALUES (servidor_sequence.nextval, 'Tiberio Zalin', '004.199.142-96', 'M', 3363.05, '(95) 98520-1478', 'zalin@email.com', 'Nivel 4', 'Adminitrador', 1002);
INSERT INTO  SERVIDORPUBLICO (matricula, nome, cpf, sexo, salario, telefone, email, escolaridade, funcao, codigo_secretaria) VALUES (servidor_sequence.nextval, 'Frederico Franco', '100.105.182-00', 'M', 4863.05, '(95) 98520-1478', 'fffrederico@email.com', 'Nivel 4', 'Adminitrador', 1000);

-- Insercao de dados FUNCIONARIOPUBLICO:
INSERT INTO  FUNCIONARIOPUBLICO (matricula_servidorpublico, gratificacao) VALUES (118, 'S');
INSERT INTO  FUNCIONARIOPUBLICO (matricula_servidorpublico, gratificacao) VALUES (100, 'N');
INSERT INTO  FUNCIONARIOPUBLICO (matricula_servidorpublico, gratificacao) VALUES (103, 'N');
INSERT INTO  FUNCIONARIOPUBLICO (matricula_servidorpublico, gratificacao) VALUES (106, 'S');
INSERT INTO  FUNCIONARIOPUBLICO (matricula_servidorpublico, gratificacao) VALUES (112, 'N');
INSERT INTO  FUNCIONARIOPUBLICO (matricula_servidorpublico, gratificacao) VALUES (121, 'N');
INSERT INTO  FUNCIONARIOPUBLICO (matricula_servidorpublico, gratificacao) VALUES (124, 'S');
INSERT INTO  FUNCIONARIOPUBLICO (matricula_servidorpublico, gratificacao) VALUES (127, 'N');
INSERT INTO  FUNCIONARIOPUBLICO (matricula_servidorpublico, gratificacao) VALUES (133, 'N');
INSERT INTO  FUNCIONARIOPUBLICO (matricula_servidorpublico, gratificacao) VALUES (136, 'S');
INSERT INTO  FUNCIONARIOPUBLICO (matricula_servidorpublico, gratificacao) VALUES (139, 'N');
INSERT INTO  FUNCIONARIOPUBLICO (matricula_servidorpublico, gratificacao) VALUES (142, 'N');
INSERT INTO  FUNCIONARIOPUBLICO (matricula_servidorpublico, gratificacao) VALUES (145, 'N');
INSERT INTO  FUNCIONARIOPUBLICO (matricula_servidorpublico, gratificacao) VALUES (151, 'N');
INSERT INTO  FUNCIONARIOPUBLICO (matricula_servidorpublico, gratificacao) VALUES (154, 'N');
INSERT INTO  FUNCIONARIOPUBLICO (matricula_servidorpublico, gratificacao) VALUES (157, 'N');
INSERT INTO  FUNCIONARIOPUBLICO (matricula_servidorpublico, gratificacao) VALUES (175, 'N');
INSERT INTO  FUNCIONARIOPUBLICO (matricula_servidorpublico, gratificacao) VALUES (178, 'N');
INSERT INTO  FUNCIONARIOPUBLICO (matricula_servidorpublico, gratificacao) VALUES (181, 'N');
INSERT INTO  FUNCIONARIOPUBLICO (matricula_servidorpublico, gratificacao) VALUES (184, 'N');
INSERT INTO  FUNCIONARIOPUBLICO (matricula_servidorpublico, gratificacao) VALUES (190, 'N');
INSERT INTO  FUNCIONARIOPUBLICO (matricula_servidorpublico, gratificacao) VALUES (193, 'N');
INSERT INTO  FUNCIONARIOPUBLICO (matricula_servidorpublico, gratificacao) VALUES (196, 'N');
INSERT INTO  FUNCIONARIOPUBLICO (matricula_servidorpublico, gratificacao) VALUES (199, 'N');
INSERT INTO  FUNCIONARIOPUBLICO (matricula_servidorpublico, gratificacao) VALUES (205, 'N');
INSERT INTO  FUNCIONARIOPUBLICO (matricula_servidorpublico, gratificacao) VALUES (208, 'N');
INSERT INTO  FUNCIONARIOPUBLICO (matricula_servidorpublico, gratificacao) VALUES (211, 'S');
INSERT INTO  FUNCIONARIOPUBLICO (matricula_servidorpublico, gratificacao) VALUES (214, 'N');
INSERT INTO  FUNCIONARIOPUBLICO (matricula_servidorpublico, gratificacao) VALUES (217, 'N');
INSERT INTO  FUNCIONARIOPUBLICO (matricula_servidorpublico, gratificacao) VALUES (223, 'N');

-- Insercao de dados FUNCIONARIOTEMPORARIO:
INSERT INTO  FUNCIONARIOTEMPORARIO (matricula_servidorpublico, comissionado, data_inicio, data_fim) VALUES (109,'S', to_date('01/01/2009','dd/mm/yyyy'), to_date('31/12/2012','dd/mm/yyyy'));
INSERT INTO  FUNCIONARIOTEMPORARIO (matricula_servidorpublico, comissionado, data_inicio, data_fim) VALUES (115,'S', to_date('01/01/2005','dd/mm/yyyy'), to_date('31/12/2008','dd/mm/yyyy'));
INSERT INTO  FUNCIONARIOTEMPORARIO (matricula_servidorpublico, comissionado, data_inicio, data_fim) VALUES (163,'N', to_date('01/01/2009','dd/mm/yyyy'), to_date('31/12/2012','dd/mm/yyyy'));
INSERT INTO  FUNCIONARIOTEMPORARIO (matricula_servidorpublico, comissionado, data_inicio, data_fim) VALUES (130,'S', to_date('01/01/2009','dd/mm/yyyy'), to_date('31/12/2012','dd/mm/yyyy'));
INSERT INTO  FUNCIONARIOTEMPORARIO (matricula_servidorpublico, comissionado, data_inicio, data_fim) VALUES (148,'S', to_date('01/01/2005','dd/mm/yyyy'), to_date('31/12/2008','dd/mm/yyyy'));
INSERT INTO  FUNCIONARIOTEMPORARIO (matricula_servidorpublico, comissionado, data_inicio, data_fim) VALUES (160,'N', to_date('01/01/2009','dd/mm/yyyy'), to_date('31/12/2012','dd/mm/yyyy'));
INSERT INTO  FUNCIONARIOTEMPORARIO (matricula_servidorpublico, comissionado, data_inicio, data_fim) VALUES (166,'N', to_date('01/01/2013','dd/mm/yyyy'), to_date('31/12/2016','dd/mm/yyyy'));
INSERT INTO  FUNCIONARIOTEMPORARIO (matricula_servidorpublico, comissionado, data_inicio, data_fim) VALUES (169,'N', to_date('01/01/2009','dd/mm/yyyy'), to_date('31/12/2012','dd/mm/yyyy'));
INSERT INTO  FUNCIONARIOTEMPORARIO (matricula_servidorpublico, comissionado, data_inicio, data_fim) VALUES (187,'S', to_date('01/01/2009','dd/mm/yyyy'), to_date('31/12/2016','dd/mm/yyyy'));
INSERT INTO  FUNCIONARIOTEMPORARIO (matricula_servidorpublico, comissionado, data_inicio, data_fim) VALUES (202,'S', to_date('01/01/2009','dd/mm/yyyy'), to_date('31/12/2012','dd/mm/yyyy'));
INSERT INTO  FUNCIONARIOTEMPORARIO (matricula_servidorpublico, comissionado, data_inicio, data_fim) VALUES (220,'S', to_date('01/01/2005','dd/mm/yyyy'), to_date('31/12/2012','dd/mm/yyyy'));
INSERT INTO  FUNCIONARIOTEMPORARIO (matricula_servidorpublico, comissionado, data_inicio, data_fim) VALUES (172,'N', to_date('01/01/2013','dd/mm/yyyy'), to_date('31/12/2016','dd/mm/yyyy'));

-- Insercao de dados EVENTO:
INSERT INTO  EVENTO (numero, nome, local, custo, data_inicio, data_fim, codigo_secretaria) VALUES (evento_sequence.nextval,'Campeonato Municipal de Futebol', 'Ginasio de Esportes Municipal', 12895.02, to_date('30/05/2010','dd/mm/yyyy'), to_date('31/07/2010','dd/mm/yyyy'), 1000);
INSERT INTO  EVENTO (numero, nome, local, custo, data_inicio, data_fim, codigo_secretaria) VALUES (evento_sequence.nextval,'Semana da Leitura', 'Centro de Eventos Iracema', 9995.22, to_date('21/08/2006','dd/mm/yyyy'), to_date('25/08/2006','dd/mm/yyyy'), 1002);
INSERT INTO  EVENTO (numero, nome, local, custo, data_inicio, data_fim, codigo_secretaria) VALUES (evento_sequence.nextval,'Jogos Olimpicos Municipal de Verao', 'Ginasio  de Esportes Municipal', 30895.15, to_date('25/05/2011','dd/mm/yyyy'), to_date('19/06/2011','dd/mm/yyyy'), 1004);
INSERT INTO  EVENTO (numero, nome, local, custo, data_inicio, data_fim, codigo_secretaria) VALUES (evento_sequence.nextval,'Feira do Agricola', 'Pavilhaoo do Acai', 45012.02, to_date('01/01/2008','dd/mm/yyyy'), to_date('05/05/2008','dd/mm/yyyy'), 1006);
INSERT INTO  EVENTO (numero, nome, local, custo, data_inicio, data_fim, codigo_secretaria) VALUES (evento_sequence.nextval,'Rodeio', 'Centro de Eventos', 7789654.99, to_date('25/08/2008','dd/mm/yyyy'), to_date('28/08/2008','dd/mm/yyyy'), 1008);
INSERT INTO  EVENTO (numero, nome, local, custo, data_inicio, data_fim, codigo_secretaria) VALUES (evento_sequence.nextval,'Sarau Literario', 'Escola Municipal Professor Filisbino Feliz', 1895.45, to_date('09/03/2015','dd/mm/yyyy'), to_date('13/03/2015','dd/mm/yyyy'), 1010);
INSERT INTO  EVENTO (numero, nome, local, custo, data_inicio, data_fim, codigo_secretaria) VALUES (evento_sequence.nextval,'Festival Regional de Artes Plasticas', 'Salao da Prefeitura Municipal', 3695.78, to_date('30/10/2008','dd/mm/yyyy'), to_date('05/11/2008','dd/mm/yyyy'), 1012);
INSERT INTO  EVENTO (numero, nome, local, custo, data_inicio, data_fim, codigo_secretaria) VALUES (evento_sequence.nextval,'Campeonato Municipal de Futebol', 'Ginasio de Esportes Municipal', 14000.63, to_date('13/10/2015','dd/mm/yyyy'), to_date('13/11/2015','dd/mm/yyyy'), 1014);
INSERT INTO  EVENTO (numero, nome, local, custo, data_inicio, data_fim, codigo_secretaria) VALUES (evento_sequence.nextval,'Feira do Agricola', 'Centro de Exposicao Municipal', 1502896.02, to_date('01/07/2015','dd/mm/yyyy'), to_date('06/07/2015','dd/mm/yyyy'), 1016);
INSERT INTO  EVENTO (numero, nome, local, custo, data_inicio, data_fim, codigo_secretaria) VALUES (evento_sequence.nextval,'Festival da Primavera', 'Centro de Eventos Municipal', 856321.02, to_date('30/09/2010','dd/mm/yyyy'), to_date('05/10/2010','dd/mm/yyyy'), 1018);
INSERT INTO  EVENTO (numero, nome, local, custo, data_inicio, data_fim, codigo_secretaria) VALUES (evento_sequence.nextval,'Campeonato Municipal de Futebol', 'Ginasio de Esportes Municipal', 15741.85, to_date('30/09/2012','dd/mm/yyyy'), to_date('30/11/2012','dd/mm/yyyy'), 1020);
INSERT INTO  EVENTO (numero, nome, local, custo, data_inicio, data_fim, codigo_secretaria) VALUES (evento_sequence.nextval,'Carnaval do Cupuacu', 'Pavilhao de Eventos', 2779632.13, to_date('02/02/2008','dd/mm/yyyy'), to_date('05/02/2008','dd/mm/yyyy'), 1022);
INSERT INTO  EVENTO (numero, nome, local, custo, data_inicio, data_fim, codigo_secretaria) VALUES (evento_sequence.nextval,'Campeonato Municipal de Ciclismo', 'Ginasio de Esportes Municipal', 9895.10, to_date('09/09/2010','dd/mm/yyyy'), to_date('09/09/2010','dd/mm/yyyy'), 1024);
INSERT INTO  EVENTO (numero, nome, local, custo, data_inicio, data_fim, codigo_secretaria) VALUES (evento_sequence.nextval,'Feira do Agricola', 'Centro de Exposiao Municipal', 2852897.99, to_date('26/04/2012','dd/mm/yyyy'), to_date('01/05/2012','dd/mm/yyyy'), 1026);
INSERT INTO  EVENTO (numero, nome, local, custo, data_inicio, data_fim, codigo_secretaria) VALUES (evento_sequence.nextval,'Exposicao Artistica de Esculturas de Madeira', 'Ginasio de Esportes Municipal', 78893.00, to_date('02/02/2016','dd/mm/yyyy'), to_date('04/02/2016','dd/mm/yyyy'), 1028);
INSERT INTO  EVENTO (numero, nome, local, custo, data_inicio, data_fim, codigo_secretaria) VALUES (evento_sequence.nextval,'Campeonato Municipal de Ciclismo', 'Ginasio de Esportes Municipal', 6695.13, to_date('31/10/2010','dd/mm/yyyy'), to_date('31/10/2010','dd/mm/yyyy'), 1030);
INSERT INTO  EVENTO (numero, nome, local, custo, data_inicio, data_fim, codigo_secretaria) VALUES (evento_sequence.nextval,'Inauguracao Hospital Madre Soraia', 'Hospital Madre Soraia', 2801.80, to_date('28/12/2015','dd/mm/yyyy'), to_date('28/12/2015','dd/mm/yyyy'), 1032);
INSERT INTO  EVENTO (numero, nome, local, custo, data_inicio, data_fim, codigo_secretaria) VALUES (evento_sequence.nextval,'Feira Literaria', 'Escola Municipal Miguelito Mrendes', 10695.12, to_date('30/06/2016','dd/mm/yyyy'), to_date('05/07/2016','dd/mm/yyyy'), 1034);
INSERT INTO  EVENTO (numero, nome, local, custo, data_inicio, data_fim, codigo_secretaria) VALUES (evento_sequence.nextval,'Campeonato Municipal de Futebol', 'Ginasio de Esportes Municipal', 12395.33, to_date('27/05/2013','dd/mm/yyyy'), to_date('29/07/2013','dd/mm/yyyy'), 1036);
INSERT INTO  EVENTO (numero, nome, local, custo, data_inicio, data_fim, codigo_secretaria) VALUES (evento_sequence.nextval,'Exposicao de Carros Antigos', 'Centro de Exposicao Municipal', 152895.96, to_date('30/05/2010','dd/mm/yyyy'), to_date('31/07/2010','dd/mm/yyyy'), 1038);
INSERT INTO  EVENTO (numero, nome, local, custo, data_inicio, data_fim, codigo_secretaria) VALUES (evento_sequence.nextval,'Campeonato Municipal de Box', 'Ginasio de Esportes Municipal', 80895.02, to_date('08/09/2011','dd/mm/yyyy'), to_date('10/09/2011','dd/mm/yyyy'), 1040);
INSERT INTO  EVENTO (numero, nome, local, custo, data_inicio, data_fim, codigo_secretaria) VALUES (evento_sequence.nextval,'Feira do Agricola', 'Centro de Exposicao Municipal', 1182895.02, to_date('15/04/2007','dd/mm/yyyy'), to_date('21/04/2007','dd/mm/yyyy'), 1042);
INSERT INTO  EVENTO (numero, nome, local, custo, data_inicio, data_fim, codigo_secretaria) VALUES (evento_sequence.nextval,'Inauguracao Hospital Padre Justino', 'Hospital Padre Justino', 13895.15, to_date('30/11/2015','dd/mm/yyyy'), to_date('30/11/2015','dd/mm/yyyy'), 1044);
INSERT INTO  EVENTO (numero, nome, local, custo, data_inicio, data_fim, codigo_secretaria) VALUES (evento_sequence.nextval,'Festa Junina', 'Centro de Eventos Municipal', 1112877.87, to_date('20/06/2010','dd/mm/yyyy'), to_date('30/06/2010','dd/mm/yyyy'), 1046);
INSERT INTO  EVENTO (numero, nome, local, custo, data_inicio, data_fim, codigo_secretaria) VALUES (evento_sequence.nextval,'Exposicao de Aviaoes Teco-Teco', 'Centro de Exposicao Municipal', 192895.53, to_date('02/06/2010','dd/mm/yyyy'), to_date('07/06/2010','dd/mm/yyyy'), 1038);
INSERT INTO  EVENTO (numero, nome, local, custo, data_inicio, data_fim, codigo_secretaria) VALUES (evento_sequence.nextval,'Festival de Madeira', 'Centro Agropecuario Municipal', 142811.68, to_date('31/08/2010','dd/mm/yyyy'), to_date('07/09/2010','dd/mm/yyyy'), 1038);
INSERT INTO  EVENTO (numero, nome, local, custo, data_inicio, data_fim, codigo_secretaria) VALUES (evento_sequence.nextval,'Carnaval Bumba Meu Boi', 'Centro de Exposicao Municipal', 222895.96, to_date('05/02/2010','dd/mm/yyyy'), to_date('09/02/2010','dd/mm/yyyy'), 1038);
 				        
-- Insercao de dados PLANEJA:
INSERT INTO  PLANEJA (matricula_servidorpublico, numero_evento,  horas) VALUES (100, 50, 920.23);
INSERT INTO  PLANEJA (matricula_servidorpublico, numero_evento,  horas) VALUES (103, 54, 168.45);
INSERT INTO  PLANEJA (matricula_servidorpublico, numero_evento,  horas) VALUES (106, 58, 655.45);
INSERT INTO  PLANEJA (matricula_servidorpublico, numero_evento,  horas) VALUES (109, 62, 300.78);
INSERT INTO  PLANEJA (matricula_servidorpublico, numero_evento,  horas) VALUES (112, 66, 825.00);
INSERT INTO  PLANEJA (matricula_servidorpublico, numero_evento,  horas) VALUES (115, 70, 135.20);
INSERT INTO  PLANEJA (matricula_servidorpublico, numero_evento,  horas) VALUES (118, 74, 212.85);
INSERT INTO  PLANEJA (matricula_servidorpublico, numero_evento,  horas) VALUES (121, 78, 925.78);
INSERT INTO  PLANEJA (matricula_servidorpublico, numero_evento,  horas) VALUES (124, 82, 1255.00);
INSERT INTO  PLANEJA (matricula_servidorpublico, numero_evento,  horas) VALUES (127, 86, 825.25);
INSERT INTO  PLANEJA (matricula_servidorpublico, numero_evento,  horas) VALUES (130, 90, 2880.15);
INSERT INTO  PLANEJA (matricula_servidorpublico, numero_evento,  horas) VALUES (133, 94, 65.00);
INSERT INTO  PLANEJA (matricula_servidorpublico, numero_evento,  horas) VALUES (136, 98, 48.00);
INSERT INTO  PLANEJA (matricula_servidorpublico, numero_evento,  horas) VALUES (139, 102, 180.89);
INSERT INTO  PLANEJA (matricula_servidorpublico, numero_evento,  horas) VALUES (139, 110, 910.74);
INSERT INTO  PLANEJA (matricula_servidorpublico, numero_evento,  horas) VALUES (142, 106, 78.89);
INSERT INTO  PLANEJA (matricula_servidorpublico, numero_evento,  horas) VALUES (145, 110, 168.78);
INSERT INTO  PLANEJA (matricula_servidorpublico, numero_evento,  horas) VALUES (148, 114, 987.56);
INSERT INTO  PLANEJA (matricula_servidorpublico, numero_evento,  horas) VALUES (151, 118, 423.85);
INSERT INTO  PLANEJA (matricula_servidorpublico, numero_evento,  horas) VALUES (154, 122, 360.74);
INSERT INTO  PLANEJA (matricula_servidorpublico, numero_evento,  horas) VALUES (157, 126, 1158.96);
INSERT INTO  PLANEJA (matricula_servidorpublico, numero_evento,  horas) VALUES (157, 130, 72.85);
INSERT INTO  PLANEJA (matricula_servidorpublico, numero_evento,  horas) VALUES (157, 134, 1356.89);
INSERT INTO  PLANEJA (matricula_servidorpublico, numero_evento,  horas) VALUES (160, 126, 920.23);
INSERT INTO  PLANEJA (matricula_servidorpublico, numero_evento,  horas) VALUES (160, 130, 168.45);
INSERT INTO  PLANEJA (matricula_servidorpublico, numero_evento,  horas) VALUES (160, 134, 655.45);
INSERT INTO  PLANEJA (matricula_servidorpublico, numero_evento,  horas) VALUES (163, 126, 1356.89);
INSERT INTO  PLANEJA (matricula_servidorpublico, numero_evento,  horas) VALUES (163, 130, 2880.15);
INSERT INTO  PLANEJA (matricula_servidorpublico, numero_evento,  horas) VALUES (163, 134, 2880.15);
INSERT INTO  PLANEJA (matricula_servidorpublico, numero_evento,  horas) VALUES (166, 138, 2880.15);
INSERT INTO  PLANEJA (matricula_servidorpublico, numero_evento,  horas) VALUES (169, 142, 1346.89);
INSERT INTO  PLANEJA (matricula_servidorpublico, numero_evento,  horas) VALUES (181, 126, 1356.89);
INSERT INTO  PLANEJA (matricula_servidorpublico, numero_evento,  horas) VALUES (181, 134, 1255.00);
INSERT INTO  PLANEJA (matricula_servidorpublico, numero_evento,  horas) VALUES (202, 54, 1155.00);
INSERT INTO  PLANEJA (matricula_servidorpublico, numero_evento,  horas) VALUES (202, 114, 825.00);
INSERT INTO  PLANEJA (matricula_servidorpublico, numero_evento,  horas) VALUES (220, 54, 625.00);
INSERT INTO  PLANEJA (matricula_servidorpublico, numero_evento,  horas) VALUES (220, 114, 87.78);
INSERT INTO  PLANEJA (matricula_servidorpublico, numero_evento,  horas) VALUES (118, 146, 3087.22);
INSERT INTO  PLANEJA (matricula_servidorpublico, numero_evento,  horas) VALUES (118, 150, 1596.80);
INSERT INTO  PLANEJA (matricula_servidorpublico, numero_evento,  horas) VALUES (118, 154, 4088.12);


/*
DROP TABLE PLANEJA;
DROP TABLE EVENTO;
DROP TABLE FUNCIONARIOTEMPORARIO;
DROP TABLE FUNCIONARIOPUBLICO;
DROP TABLE SERVIDORPUBLICO;
DROP TABLE SECRETARIA;
DROP TABLE PREFEITURA;
*/

-- ###########################################################################################################################################################
--                                           PRIMEIRA PARTE
-- ###########################################################################################################################################################

-- Criar no maximo 3 visoes, podendo ser simples ou complexas (envolvendo junsoes, funcoes de agrupamento, etc);

-- 1. View que lista todos os funcionarios temporarios: 
CREATE VIEW v_funcionariotemporario_lista(funcionariotemporario) AS
    SELECT f.nome FROM funcionariotemporario
        JOIN servidorpublico f ON funcionariotemporario.matricula_servidorpublico = f.matricula;
SELECT * FROM v_funcionariotemporario_lista;         

-- 2. View que lista os servidores publicos que trabalham na secretaria de codigo 1038:  
CREATE VIEW v_servidorpublico AS
SELECT matricula, nome, cpf, escolaridade, funcao, codigo_secretaria
        FROM servidorpublico
        WHERE codigo_secretaria = 1038;
SELECT * FROM v_servidorpublico; 
 

-- 3. View que lista todos os funcionarios publicos: 
CREATE VIEW v_funcionariopublico_lista(funcionariopublico) AS
    SELECT f.nome FROM funcionariopublico
        JOIN servidorpublico f ON funcionariopublico.matricula_servidorpublico = f.matricula;
SELECT * FROM v_funcionariopublico_lista; 

-- Criar no maximo 1 visao materializada com refresh on demand (sob demanda):
CREATE MATERIALIZED VIEW custo_eventos_2021
    BUILD DEFERRED
    REFRESH COMPLETE
    ON DEMAND
    AS SELECT SUM(custo) custo_total FROM evento
        WHERE data_inicio >= TO_DATE('01/01/2010', 'dd/mm/yyyy')
                  AND data_fim <= TO_DATE('31/12/2010', 'dd/mm/yyyy');
        
-- Elaborar 8 consultas SELECT utilizando recursos e funcoes aprendidas em Oracle (juncao, subconsulta, agregacao de dados, funsoes de manipulacao de caracteres, etc):

-- 1. Seleciona a soma salarial por codigo das secretarias apenas para as mesmas com soma salarial superior a 10.000:
SELECT codigo_secretaria, SUM(salario)
    FROM servidorpublico
    GROUP BY codigo_secretaria
    HAVING SUM(salario) > 10000;

-- 2. Seleciona as ocorrencias de sexo e acrescenta por extenso o siginificado:    
SELECT nome, sexo,
    DECODE(sexo, 'M', 'Masculino', 'F', 'Feminino')
    FROM servidorpublico;

-- 3. Seleciona o valor maximo, minimo e media salarial dos servidores publicos:
SELECT MAX(salario), MIN(salario), AVG(salario),
    SUM(salario), COUNT(*)
    FROM servidorpublico
    GROUP BY salario;
    
-- 4. Seleciona o maior custo do projeto da secretaria de codigo 1038:
SELECT max(custo)
    FROM evento
    WHERE codigo_secretaria = 1038;

-- 5. Seleciona o funcionario responsavel pelo planejamento de evento:
select e.numero, e.nome, s.nome from planeja es, evento e, servidorpublico s
    where es.numero_evento = s.matricula and es.matricula_servidorpublico = e.numero
    order by numero_evento;

-- 6. Seleciona a quantidade de servidores publicos por sexo;
SELECT sexo, count(*)
    FROM servidorpublico
    GROUP BY sexo;
    
-- 7. Seleciona a subconsulta que mostre o cpf, nome e salario dos servidores publicos que ganham mais do que o funcionario Crispim Epaminondas.
SELECT cpf, nome, salario
    FROM servidorpublico
        WHERE salario > (SELECT salario FROM servidorpublico
        WHERE nome = 'Crispim Epaminondas');

-- 8.  Seleciona uma listagem ÃÂºnica que contenha as matriculas dos servidores publicos temporarios e efetivos:
SELECT matricula_servidorpublico
    FROM funcionariopublico
UNION
SELECT matricula_servidorpublico
    FROM funcionariotemporario;


-- ###########################################################################################################################################################
--                                           SEGUNDA PARTE
-- ###########################################################################################################################################################
SET SERVEROUTPUT ON;

-- No minimo 2 funcoes, podendo ter qualquer comportamento, bastando apenas adicionar comentarios no codigo explicando o que elas devem fazer;

-- 1. Funcao na qual recebe como parametro o nome de um servidor publico (funcionario) e retorna a soma das horas trabalhadas no planejamento dos eventos
-- O servidor publico sera buscado pelo seu nome e caso nao seja encontrado, uma mensagem de erro e apresentada
CREATE OR REPLACE FUNCTION FU_HORAS__PLANEJAMENTO_EVENTO_SERVDORPUBLICO( -- Cabeçalho da funcao
    p_nome IN servidorpublico.nome%TYPE -- Parametro de entrada nome do servidor publico para ser chave de busca 
) RETURN NUMBER IS -- Retorno da funcao sera do tipo numerico (horas)
    v_totalhoras NUMBER; -- Variavel auxiliar que ira receber o numero de horas plenejadas do evento
    
BEGIN -- Bloco dos procedimentos 
    SELECT SUM(planeja.horas) INTO v_totalhoras FROM planeja -- Selecao com funcao soma das horas para variavel auxiliar para tabela planeja
        JOIN evento ON planeja.numero_evento = evento.numero -- Juncao da tabela evento com a tabela planeja (FK com PK)
        JOIN servidorpublico ON planeja.matricula_servidorpublico = servidorpublico.matricula -- Juncao da tabela servidorpublico com a tabela planeja (FK com PK)
        WHERE servidorpublico.nome = p_nome; -- Indica qual o funcionario pelo parametro passado
    RETURN v_totalhoras; -- Retorna para variavel auxiliar a somas das horas do planejamento do evento
EXCEPTION -- Tratamento de excecao
    WHEN NO_DATA_FOUND THEN -- Envio de uma mensagem caso nao seja possivel enconrar o funcionario
        DBMS_OUTPUT.PUT_LINE('Nenhum funcionario encontrado!');  
    WHEN OTHERS THEN -- Envio de uma mensagem generica
        DBMS_OUTPUT.PUT_LINE('ERRO: ' || sqlerrm);
END FU_HORAS__PLANEJAMENTO_EVENTO_SERVDORPUBLICO; -- Fim da funcao

SELECT FU_HORAS__PLANEJAMENTO_EVENTO_SERVDORPUBLICO('Filomena Fiica Mendes') AS Total_Horas FROM DUAL; -- Executa a operacao da funcao passando o parametro (nome do servidor publico) 


-- 2. Funcao na qual recebe como parametro o codigo de uma secretaria municipal e retorna a media do custo dos eventos monitorados por ela
-- A secretaria sera buscada pelo seu codigo e caso nao seja encontrada, uma mensagem de erro e apresentada
CREATE OR REPLACE FUNCTION FU_MEDIA_CUSTO_EVENTO_SECRETARIA( -- Cabeçalho da funcao
    p_secretaria evento.codigo_secretaria%TYPE -- Parametro de entrada para codigo da secretaria para ser chave de busca
) RETURN NUMBER AS -- Retorno da funcao sera do tipo numerico (custo)
    v_mediacusto NUMBER; -- Variavel auxiliar que ira receber o valor do curto do evento monitorado pela secretaria
BEGIN -- Bloco dos procedimentos 
    SELECT AVG(custo) INTO v_mediacusto FROM evento WHERE codigo_secretaria = p_secretaria; -- Selecao com funcao media dos custos para variavel auxiliar para tabela evento
    RETURN v_mediacusto; -- Retorna para variavel auxiliar a media do custo dos eventos monitorados pela secretaria
    
EXCEPTION -- Tratamento de excecao
    WHEN NO_DATA_FOUND THEN -- Envio de uma mensagem caso nao seja possivel enconrar a secretaria
        DBMS_OUTPUT.PUT_LINE('Nenhuma secretaria encontrada!');  
    WHEN OTHERS THEN -- Envio de uma mensagem generica
        DBMS_OUTPUT.PUT_LINE('ERRO: ' || sqlerrm);
END FU_MEDIA_CUSTO_EVENTO_SECRETARIA; -- Fim da funcao

SELECT codigo, nome, ROUND(FU_MEDIA_CUSTO_EVENTO_SECRETARIA(codigo),2) AS MEDIA_CUSTO_EVENTOS FROM secretaria WHERE codigo = 1038; -- Executa a operacao da funcao passando o parametro (o codigo da secretaria) 
SELECT codigo, nome, ROUND(FU_MEDIA_CUSTO_EVENTO_SECRETARIA(codigo),2) AS MEDIA_CUSTO_EVENTOS FROM secretaria; --  -- Executa a operacao trazendo a media de custo dos eventos monitorados por todas as secretarias


-- No minimo 2 procedures, podendo ter qualquer comportamento, bastando apenas adicionar comentarios no codigo explicando o que elas devem fazer:

-- 1. Procedure receba por parametro o codigo de uma secretaria e o percentual de acrescimo nos custos dos eventos vinculados a essa secretaria
-- O evento sera buscado pelo seu numero e caso nao seja encontrado uma mensagem de erro e apresentada
-- O resultado ira apresentar mais de uma linha, entao sera aplicado cursor
CREATE OR REPLACE PROCEDURE PR_REAJUSTA_CUSTO_SECRETARIA ( -- Cabecalho e criacao da procedure 
    p_secretaria  IN evento.codigo_secretaria%TYPE, -- Parametro de entrada para codigo da secretaria para ser chave de busca 
    p_acrescimo   IN NUMBER -- Parametro de entrada para acrescimo do cursto de dos eventos a ser altaredos
) AS
    CURSOR c_eventosecretaria IS -- Aplicacao do cursor para retornar mais de uma linha
        SELECT numero FROM evento -- Selecao dos paramentros e vaiaveis na tabela evento
            WHERE codigo_secretaria = p_secretaria; -- Indicacao da secretaria que sera feita a alteracao
BEGIN -- Bloco dos procedimentos 
    FOR r_eventosecretaria IN c_eventosecretaria -- For na qual nao precisa declarar a variavel r_eventosecretaria, em que o for ira processar o cursor c_eventosecretaria
    LOOP                                         -- em que o limite inferior e superior para estrutura de repeticao estao no cursor (semelhante ao fetch)
        UPDATE evento SET custo = custo * (1 + p_acrescimo/100) -- Aplicacao do percentual de acrescimo
            WHERE numero = r_eventosecretaria.numero; -- Indicacao da secretaria que ira receber o acrescimo 
    END LOOP; -- Fim da iteracao

EXCEPTION -- Tratamento de excecao
    WHEN NO_DATA_FOUND THEN -- Envio de uma mensagem caso nao seja possivel enconrar a secretaria
        DBMS_OUTPUT.PUT_LINE('Nenhum funcionario encontrado!');
    WHEN OTHERS THEN -- Envio de uma mensagem generica
        DBMS_OUTPUT.PUT_LINE('ERRO: ' || sqlerrm);
    ROLLBACK; -- Voltar ao estado original da procedure
    
END PR_REAJUSTA_CUSTO_SECRETARIA; -- Fim da procedure

SELECT * FROM evento WHERE codigo_secretaria = 1038; -- Consulta para verificar antes da alteracao 

EXEC PR_REAJUSTA_CUSTO_SECRETARIA(1038, 50); -- Executa a operacao da procedure passando os parametros (codigo da secretaria e a porcentagem de acrescimo) 

SELECT * FROM evento WHERE codigo_secretaria = 1038; -- Consulta para verificar depois da alteracao


-- 2. Procedure que atribui uma nova funcao ao funcionario, passando por parametros o nome do funcionario e a nova funcao
-- Funcionario sera buscado pelo seu numero de matricula e caso nao seja encontrado uma mensagem de erro e apresentada 
CREATE OR REPLACE PROCEDURE PR_NOVA_FUNCAO ( -- Cabecalho e criacao da procedure 
    p_nome_servidorpublico      IN servidorpublico.nome%TYPE, -- Parametro de entrada para nome do funcionatio para ser chave de busca 
    p_funcao_servidorpublico    IN servidorpublico.funcao%TYPE -- Parametro de entrada para funcao do funcionario a ser altaredo
    ) IS
    v_matricula_servidorpublico servidorpublico.matricula%TYPE; -- Variavel auxiliar que ira receber o numero de matricula do funcionario

BEGIN -- Bloco dos procedimentos 
    SELECT servidorpublico.matricula INTO v_matricula_servidorpublico FROM servidorpublico -- Selecao dos paramentros e vaiaveis na tabela do servidorpublico
        WHERE nome = p_nome_servidorpublico; -- Indica qual o funcionario
    UPDATE servidorpublico SET servidorpublico.funcao = p_funcao_servidorpublico -- Update para altarar a funcao do funcionario
        WHERE matricula = v_matricula_servidorpublico; -- Indicacao da linha que sera feita a alteracao
        DBMS_OUTPUT.PUT_LINE('Nova funcao atrabuida!'); -- Mensagem informando que a operacao foi concluida
    COMMIT; -- Mensagem informando que a operacao foi concluida
  
EXCEPTION -- Tratamento de excecao
    WHEN NO_DATA_FOUND THEN -- Envio de uma mensagem caso nao seja possivel enconrar o funcionario
        DBMS_OUTPUT.PUT_LINE('Nenhum funcionario encontrado!');
    WHEN TOO_MANY_ROWS THEN -- Envio de uma mensagem caso o resultado encontre mais e um funcionario (mais de uma linha)
        DBMS_OUTPUT.PUT_LINE('Mais de um funcionario encontrado!');  
    WHEN OTHERS THEN -- Envio de uma mensagem generica
        DBMS_OUTPUT.PUT_LINE('ERRO: ' || sqlerrm);
        
END PR_NOVA_FUNCAO; -- Fim da procedure

SELECT matricula, nome, funcao FROM servidorpublico WHERE matricula = 223; -- Consulta para verificar antes da alteracao 

EXEC PR_NOVA_FUNCAO('Frederico Franco', 'Chefe de Gabinete'); -- Executa a operacao da procedure passando os parametros (numero do funcionario e nova funcao) 
                                                                    
SELECT matricula, nome, funcao FROM servidorpublico WHERE matricula = 223; -- Consulta para verificar a alteracao


-- 3. Procedure que altera o nome de um evento, o seu custo e a secretaria vinculada. 
-- O evento sera buscado pelo seu numero e caso nao seja encontrado uma mensagem de erro e apresentada

CREATE OR REPLACE PROCEDURE PR_ALTERA_EVENTO_NOME_CUSTO_SECRETARIA( -- Cabecalho e criacao da procedure 
    p_numero     IN evento.numero%TYPE, -- Parametro de entrada para numero do evento para ser chave de busca
    p_nome       IN evento.nome%TYPE, -- Parametro de entrada para nome do evento a ser altaredo
    P_custo      IN evento.custo%TYPE, -- Parametro de entrada para custo do evento a ser altaredo    
    p_secretaria IN evento.codigo_secretaria%TYPE)-- Parametro de entrada para codigo da secretaria a ser altareda
    IS
    v_auxiliar   NUMBER; -- Variavel auxiliar que ira receber o valor do numero do evento
    
BEGIN -- Bloco dos procedimentos 
    SELECT COUNT(*) INTO v_auxiliar FROM evento WHERE numero = p_numero; -- Verifica se existe o evento via numero passado por parametro
    IF v_auxiliar > 0 THEN -- Condicional que indica se encontrou o evento
        UPDATE evento SET nome = p_nome, custo = p_custo, codigo_secretaria = p_secretaria -- Update para altarar os dados do nome, custo e secretaria vinculada
            WHERE numero = p_numero; -- Indicacao da linha que sera feita a alteracao
            DBMS_OUTPUT.PUT_LINE('O evento foi atualizado!'); -- Mensagem informando que a operacao foi concluida
        COMMIT; -- Conclusao e envio da operacao
    END IF; -- Fim da condicional
    
EXCEPTION -- Tratamento de excecao
    WHEN NO_DATA_FOUND THEN -- Envio de uma mensagem caso nao seja possivel enconrar o evento
        DBMS_OUTPUT.PUT_LINE('Nenhum funcionario encontrado!');
    WHEN TOO_MANY_ROWS THEN -- Envio de uma mensagem caso o resultado encontre mais e um funcionario (mais de uma linha)
        DBMS_OUTPUT.PUT_LINE('Mais de um funcionario encontrado!');  
    WHEN OTHERS THEN -- Envio de uma mensagem generica
        DBMS_OUTPUT.PUT_LINE('ERRO: ' || sqlerrm);

END PR_ALTERA_EVENTO_NOME_CUSTO_SECRETARIA; -- Fim da procedure

SELECT numero, nome, custo, codigo_secretaria FROM evento WHERE numero = 66;  -- Consulta para verificar antes da alteracao  

EXEC PR_ALTERA_EVENTO_NOME_CUSTO_SECRETARIA(66, 'Circuito Nacional de Rodeio', 8999999, 1020); -- Executa a operacao da procedure passando os parametros (numero do evento, 
                                                                          -- nome do evento, custo e o codigo da secretaria)
SELECT numero, nome, custo, codigo_secretaria FROM evento WHERE numero = 66;  -- Consulta para verificar a alteracao


-- No minimo 2 triggers, podendo modificar automaticamente a propria tabela ou outras, ou ainda populando tabelas de log. 
-- Ao menos uma delas deve utilizar referencia as tuplas :NEW ou :OLD. E fundamental adicionar comentarios no codigo explicando o que elas devem fazer;

-- 1. Trigger em Nível de Instrução

-- Trigger que popula as operacoes em uma tablela EVENTO_LOG nas alteracoes, insercoes e exclusao de dados da tabela Evento
CREATE TABLE EVENTO_LOG( -- Criada uma nova tabela EVENTO_LOG para armazenar os registros das alteracao feitas na tabela Evento
    usuario           VARCHAR2(20), -- Identificar quem foi usuario que efetuou a alteracao
    data_alteracao    TIMESTAMP, -- Data em que ocorreu a alteracao exata com timestamp
    operacao          VARCHAR2(30), -- Apresenta a mensagem da operacao feita
    CONSTRAINT EVENTO_LOG_PK PRIMARY KEY (usuario, data_alteracao) -- PK para usuario e data_alteracao, pois podem ocorrer varias alteracoes seguidas
);                                                                 -- e o timestamp irá distinguir essas alteracoes

CREATE OR REPLACE TRIGGER TR_EVENTO_LOG_OPERACAO -- Cabecalho e criacao do Trigger 
    AFTER INSERT OR DELETE OR UPDATE -- Apos a conclusao do DML (na tabela Evento), as operacoes serao realizadas na tabela generica EVENTO_LOG 
        ON charles.EVENTO -- Indicacao do usuario para tabela evento que recebeu alteracao 
    
DECLARE -- Bloco da declararacao de variaveis
        v_operacao EVENTO_LOG.operacao%TYPE; --Declaracao da variavel auxiliar do tipo operacao
        
BEGIN -- Bloco dos procedimentos 
    IF INSERTING THEN -- Consicional se o evento disparador for um INSERTING 
        v_operacao := 'INSERCAO REALIZADA COM SUCESSO'; -- entao e armazenado a mensagem na variavel v_operacao
    ELSIF UPDATING THEN -- Consicional se o evento disparador for um UPDATING
        v_operacao := 'ATUALIZACAO REALIZADA COM SUCESSO'; -- entao e armazenado a mensagem na variavel v_operacao
    ELSIF DELETING THEN -- Consicional se o evento disparador for um DELETING
        v_operacao := 'REMOCAO REALIZADA COM SUCESSO'; -- entao e armazenado a mensagem na variavel v_operacao
    END IF; -- Fim da condicional
    
    INSERT INTO EVENTO_LOG VALUES (user, sysdate, v_operacao); -- Apos amarzenar a mensagem na variavel auxiliar é feito um insert na tabela EVENTO_LOG
                                                               -- com valores da indicao do usuario, a data de alteracao e operecao que disparou a Trigger
END TR_EVENTO_LOG_OPERACAO; -- Fim do Trigger

-- Exemplo de um insert na tabela evento:
INSERT INTO  EVENTO (numero, nome, local, custo, data_inicio, data_fim, codigo_secretaria) VALUES (evento_sequence.nextval,'Campeonato de Xadrez', 'Ginasio Municipal', 1895.96, to_date('10/07/2010','dd/mm/yyyy'), to_date('11/07/2010','dd/mm/yyyy'), 1038);
SELECT * FROM evento; -- Verifica a inclusao na tabela Eventos
SELECT * FROM evento_log; -- Verifica a inclusão na tabela evento_log a operacao que disparou a Trigger

-- 2. Trigger Nível de Linha

-- Trigger especifica que ira atualizar o valor de custo de um evento, apresentando o valor antigo e o valor novo em uma tabela de de auditoria
CREATE TABLE AUDIT_EVENTO_CUSTO( -- Tabela de auditoria para armazenar os disparos das Triggers
    numero_evento_audit    NUMBER(10) NOT NULL, -- numero do evento da tabela de auditoria
    valor_custo_antigo     NUMBER(10,2) NOT NULL, -- custo antigo
    valor_custo_novo       NUMBER(10,2) NOT NULL, -- custo novo
    usuario                VARCHAR2(20), -- usuario que efetuou a alteracao
    data_alteracao         TIMESTAMP, -- Data em que ocorreu a alteracao exata com timestamp
    CONSTRAINT AUDIT_EVENTO_CUSTO_FK FOREIGN KEY (numero_evento_audit) REFERENCES EVENTO(numero), -- FK com a tabela Evento
    CONSTRAINT AUDIT_EVENTO_CUSTO_PK PRIMARY KEY (numero_evento_audit, data_alteracao) -- PK para numero_evento_audit e data_alteracao, 
);                                                                                     -- pois podem ocorrer varias alteracoes seguidas
                                                                                   -- e o timestamp irá distinguir essas alteraco
CREATE OR REPLACE TRIGGER TR_AUDIT_EVENTO_CUSTO -- Cabecalho e criacao do Trigger
    BEFORE UPDATE OF custo -- o trigger sera disparado antes que do disparo seja executado
        ON charles.EVENTO -- Indicacao do usuario para tabela evento que recebeu alteracao 
    FOR EACH ROW -- Inficar o nivel da linha (tupla)...
        WHEN (NEW.custo <> OLD.custo) -- ... acionando quando o custo novo for diferente do custo antigo (usando old o evento é before)
    
BEGIN -- Bloco dos procedimentos 
    -- E feito um insert na tabela AUDIT_EVENTO_CUSTO com valores do numero do evento, custo antigo, custo novo, usuario que alterou e data de alteracao
    INSERT INTO AUDIT_EVENTO_CUSTO VALUES (:NEW.numero, :OLD.custo, :NEW.custo, user, sysdate);

END TR_AUDIT_EVENTO_CUSTO; -- Fim da Trigger

SELECT * FROM evento; -- Tabela evento antes da alteração
UPDATE evento SET custo = 8000000 WHERE numero = 66; -- Novo valor de custo para o evento de numero 66
SELECT * FROM AUDIT_EVENTO_CUSTO; -- Verifica a inclusão na tabela AUDIT_EVENTO_CUSTO a operacao que disparou a Trigger

-- Na sequencia, você deve analisar as consultas elaboradas na Parte 1 do trabalho. Se forem boas o suficiente e possuírem predicados (filtros na clausula WHERE), 
-- solicite o plano de explicacao de ao menos 3 delas e veja se podem ter seus desempenhos melhorados com a utilização de indices. 
-- Crie os devidos indices, se necessario. No caso de as consultas não forem boas o suficiente, crie novas que permitam uma melhor análise e melhoria de desempenho.

-- 1. Index
-- Seelciona um servidor pubublico especifico
SELECT * FROM servidorpublico;
SELECT * FROM servidorpublico WHERE nome = 'Balthazar Gregorio';
CREATE INDEX servidorpublico_nome_IX ON servidorpublico(nome);
-- Custo etimado foi de  3 (full)  para 1 (range scan)

-- 2. Index
-- Seleciona o maior custo do projeto da secretaria de codigo 1038:
SELECT max(custo)
    FROM evento
    WHERE codigo_secretaria = 1038;
CREATE INDEX evento_custo_secretaria_IX ON evento(codigo_secretaria);
-- Custo etimado foi de  3 (full)  para 1 (range scan)

-- 3. Index
-- Seleciona o servidor publico de sexo masculino:
SELECT * FROM servidorpublico WHERE sexo = 'M';
CREATE INDEX servidorpublico_sexo_IX ON servidorpublico(sexo);
-- Custo etimado foi de  3 (full)  para 1 (range scan)

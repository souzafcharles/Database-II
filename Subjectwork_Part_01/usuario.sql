-- USUARIO:

-- Inserir ao menos uma linha em cada uma das duas tabelas que ganhou acesso:
INSERT INTO  SERVIDORPUBLICO (matricula, nome, cpf, sexo, salario, telefone, email, escolaridade, funcao, codigo_secretaria) VALUES (charles.servidor_sequence.nextval, 'Paolo Di Paula', '554.185.182-20', 'M', 9863.05, '(95) 98888-1478', 'dipaula@email.com', 'Nível 4', 'Adminitrador', 1000);
INSERT INTO  EVENTO (numero, nome, local, custo, data_inicio, data_fim, codigo_secretaria) VALUES (charles.evento_sequence.nextval, 'Festival Catirina e Cazumbá', 'Centro de Eventos Municipal', 232877.87, to_date('20/03/2016','dd/mm/yyyy'), to_date('06/03/2016','dd/mm/yyyy'), 1046);

-- Consultar dados de ao menos duas tabelas;
select * from servidorpublico;
select * from evento;
select * from charles.v_servidorpublico;
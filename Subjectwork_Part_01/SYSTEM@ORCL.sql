-- SYSTEM:

-- Criar um usuario no oracle (seu nome) e conceder as devidas permissoes de acesso a ele: 

ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

CREATE USER charles IDENTIFIED BY charles;

CREATE ROLE desenvolvedor;

-- Concessão de Acesso:
GRANT
    CREATE SESSION,
    CREATE ANY TABLE,
    SELECT ANY TABLE,
    INSERT ANY TABLE,
    UPDATE ANY TABLE,
    CREATE ANY SEQUENCE,
    CREATE ANY VIEW TO desenvolvedor;
    
-- Atribuindo acesso de desenvolvedor ao usuário charles:
GRANT desenvolvedor TO charles;
ALTER USER charles QUOTA UNLIMITED ON USERS;

-- Criar um novo usuario (nome qualquer) e conceder a ele:
CREATE USER usuario IDENTIFIED BY usuario;

-- Permissoes de acesso ao banco de dados:
GRANT CREATE SESSION TO usuario, desenvolvedor;

-- Consulta (SELECT) em todas as tabelas do BD:
GRANT SELECT ON charles.prefeitura TO usuario, desenvolvedor;
GRANT SELECT ON charles.secretaria TO usuario, desenvolvedor;
GRANT SELECT ON charles.servidorpublico TO usuario, desenvolvedor;
GRANT SELECT ON charles.funcionariopublico TO usuario, desenvolvedor;
GRANT SELECT ON charles.funcionariotemporario TO usuario, desenvolvedor;
GRANT SELECT ON charles.evento TO usuario, desenvolvedor;
GRANT SELECT ON charles.planeja TO usuario, desenvolvedor;

-- Insert, Update, Delete em duas das tabelas:
GRANT INSERT, UPDATE, DELETE ON charles.servidorpublico TO usuario, desenvolvedor;
GRANT INSERT, UPDATE, DELETE ON charles.evento TO usuario, desenvolvedor;

-- Consulta nas views:
GRANT SELECT ON charles.v_servidorpublico TO usuario;
GRANT SELECT ON charles.v_funcionariopublico_lista TO usuario;
GRANT SELECT ON charles.v_funcionariotemporario_lista TO usuario;

-- Inclusao do usuario nas sequences envolvidas nas tabelas em que ganhou acesso de Insert, Update e Delete:
grant select, alter on charles.servidor_sequence to usuario;
grant select, alter on charles.evento_sequence to usuario;

-- Revogar o acesso de delete concedido ao usuario as duas tabelas do item anterior:
REVOKE DELETE ON charles.servidorpublico FROM usuario;
REVOKE DELETE ON charles.evento FROM usuario;




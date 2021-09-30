ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

CREATE USER HR IDENTIFIED BY hr;

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
GRANT desenvolvedor TO HR;
ALTER USER HR QUOTA UNLIMITED ON USERS;

-- Permiss�o para criar procedures:
GRANT CREATE PROCEDURE TO HR;
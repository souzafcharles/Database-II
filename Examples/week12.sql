CREATE TABLE audit_atleta_sal(
     id_atleta        NUMBER(4),
     sal_antigo      NUMBER(8,2),
     sal_novo        NUMBER(8,2),
     usuario           VARCHAR2(20),
     data_alt          TIMESTAMP,
     CONSTRAINT AUDIT_ATL_SAL_PK PRIMARY KEY(id_atleta, data_alt),
     CONSTRAINT AUDIT_ATL_SAL_ID_FK FOREIGN KEY(id_atleta)
          REFERENCES atleta (id)
);
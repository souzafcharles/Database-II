/* 1. Fa�a uma fun��o chamada fu_calcula_reajuste que receba por
par�metro o c�digo de um atleta e o percentual de reajuste do
sal�rio. A fun��o deve aplicar o percentual de reajuste ao sal�rio
e retornar o novo sal�rio calculado do atleta. Depois, atualize o
sal�rio de algum atleta utilizando a fun��o criada.*/

select * from atleta;

SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION fu_calcula_reajuste(
    p_id_atleta IN ATLETA.ID%TYPE,
    p_acrescimo IN NUMBER
    
) RETURN NUMBER IS

    v_salario_reajustado ATLETA.SALARIO%TYPE;

BEGIN
    SELECT salario INTO v_salario_reajustado
        FROM ATLETA
    WHERE ID = p_id_atleta;
    
    RETURN v_salario_reajustado + (v_salario_reajustado * p_acrescimo);

END fu_calcula_reajuste;

SELECT fu_calcula_reajuste(2, 0.01) AS SALARIO_REAJUSTADO FROM DUAL;  


/* 2. Fa�a uma procedure chamada PR_REAJUSTA_SAL_CLUBE que
receba por par�metro o id de um clube e o percentual de
reajuste. Aplique e atualize na tabela o sal�rio dos atletas do
clube passado por par�metro, aplicando o % de reajuste
informado. Utilize cursor para resolver o exerc�cio e treinar
sua utiliza��o. Depois, execute a procedure reajustando os
sal�rios dos atletas de algum clube.*/  

select * from clube;

CREATE OR REPLACE PROCEDURE PR_REAJUSTA_SAL_CLUBE(

    p_info_clube IN ATLETA.ID%TYPE,
    p_acrescimo IN NUMBER
) AS
    CURSOR c_clube_atleta IS
        SELECT ID FROM atleta WHERE id_clube = p_info_clube;

BEGIN
    FOR cont_clube_atleta IN c_clube_atleta LOOP
        UPDATE atleta SET salario = salario *(2 + p_acrescimo/100) 
        WHERE ID = cont_clube_atleta.id; 
    END LOOP;
    
EXCEPTION

    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT('ERRO:  ' || sqlerrm);
        ROLLBACK;
END PR_REAJUSTA_SAL_CLUBE;

SELECT * FROM atleta WHERE id_clube = 2;

    
/* 3. Fa�a uma procedure chamada pr_calcula_reajuste2 que
transforme a fun��o feita no exerc�cio 1 em uma procedure.
Acrescente um par�metro de sa�da que recebe o novo sal�rio
do atleta. Crie um bloco PL/SQL para chamar a procedure.*/    

CREATE OR REPLACE PROCEDURE pr_calcula_reajuste2


END pr_calcula_reajuste2;























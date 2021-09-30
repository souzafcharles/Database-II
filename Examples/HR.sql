SET SERVEROUTPUT ON;


-- Procura um atleta pelo id. 
DECLARE
    v_nome atleta.nome%TYPE;
BEGIN
    SELECT nome INTO v_nome FROM Atleta WHERE id = 1;
    DBMS_OUTPUT.PUT_LINE('Nome: ' || v_nome);
EXCEPTION
    WHEN NO_DATA_FOUND THEN -- excecão caso não encontrar o id do atleta
    DBMS_OUTPUT.PUT_LINE('Atleta não encontrado');  
END;


-- Procura um atleta pelo id do clube

DECLARE
    v_nome atleta.nome%TYPE;
BEGIN
    SELECT nome INTO v_nome FROM Atleta WHERE id_clube = 1;
    DBMS_OUTPUT.PUT_LINE('Nome: ' || v_nome);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Atleta não encontrado');
    WHEN TOO_MANY_ROWS THEN
    DBMS_OUTPUT.PUT_LINE('Mais de um atleta encontrado');    
END;

-- Cursor com loop
DECLARE
    v_nome atleta.nome%TYPE;
    CURSOR c_atleta IS SELECT nome FROM Atleta WHERE id_clube = 1;
BEGIN
    OPEN c_atleta;
    LOOP
        FETCH c_atleta INTO v_nome;
        EXIT WHEN c_atleta%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Nome: ' || v_nome);
    END LOOP;
    CLOSE c_atleta;
EXCEPTION
    WHEN NO_DATA_FOUND THEN -- excecão caso não encontrar o id do atleta
    DBMS_OUTPUT.PUT_LINE('Atleta não encontrado');
    WHEN TOO_MANY_ROWS THEN -- excecão caso encontrar mais que um atleta pelo id do clube
    DBMS_OUTPUT.PUT_LINE('Mais de um atleta encontrado');
    WHEN OTHERS THEN -- excecão genérica com mensagem do erro Oracle
    DBMS_OUTPUT.PUT_LINE('Erro inesperado: ' || sqlerrm); 
END;

-- Cursor com for
DECLARE
    CURSOR c_atleta IS SELECT nome FROM Atleta WHERE id_clube = 1;
BEGIN
    for v_atleta IN c_atleta LOOP
        DBMS_OUTPUT.PUT_LINE('Nome: ' || v_atleta.nome);
    END LOOP;
EXCEPTION
    WHEN NO_DATA_FOUND THEN -- excecão caso não encontrar o id do atleta
    DBMS_OUTPUT.PUT_LINE('Atleta não encontrado');
    WHEN TOO_MANY_ROWS THEN -- excecão caso encontrar mais que um atleta pelo id do clube
    DBMS_OUTPUT.PUT_LINE('Mais de um atleta encontrado');
    WHEN OTHERS THEN -- excecão genérica com mensagem do erro Oracle
    DBMS_OUTPUT.PUT_LINE('Erro inesperado: ' || sqlerrm); 
END;




create or replace procedure pr_altera_atleta_end_clube(
    p_id in atleta.id%type,
    p_end in atleta.endereco%type,
    p_clube in atleta.id_clube%type)
    is
    v_aux number;
begin
    --Verificar se existe o atleta
    select count(*) into v_aux from atleta where id = p_id;

    if v_aux > 0 then
        update atleta set ENDERECO = p_end, ID_CLUBE = p_clube
            where id = p_id;
        DBMS_OUTPUT.PUT_LINE('Atleta atualizado com sucesso');
        commit;
    end if;
exception
    when others then
        DBMS_OUTPUT.PUT_LINE('Erro ' || sqlerrm);
end pr_altera_atleta_end_clube;

-- Executar procedure
call pr_altera_atleta_end_clube(80, 'Teste Procedure', 7);



CREATE OR REPLACE PROCEDURE PR_REAJUSTA_SAL_CLUBE (
    P_CLUBE IN ATLETA.ID_CLUBE%TYPE,
    P_PERCENTUAL IN NUMBER
) AS
    CURSOR C_ATLCLUBE IS
        SELECT ID FROM ATLETA WHERE ID_CLUBE = P_CLUBE;
BEGIN
    FOR R_ATELTACLUBE IN C_ATLCLUBE LOOP
        UPDATE ATLETA SET SALARIO = SALARIO * (1 + P_PERCENTUAL/100) WHERE ID = R_ATELTACLUBE.ID;
    END LOOP;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERRO: ' || SQLERRM);
        ROLLBACK;
END PR_REAJUSTA_SAL_CLUBE;

SELECT * FROM ATLETA WHERE ID_CLUBE = 10;
CALL PR_REAJUSTA_SAL_CLUBE(10, 5);
SELECT * FROM ATLETA WHERE ID_CLUBE = 10;





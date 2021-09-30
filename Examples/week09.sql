-- CURSOR:
-- uso de CURSOR:
-- Modo 1:
declare
    v_id atleta.id%type;
    v_nome atleta.nome%type;
    v_salario atleta.salario%type;
    cursor c_atleta is
        select id, nome, salario into v_id, v_nome, v_salario from ATLETA;
begin
    -- abre o cursor
    open c_atleta;
    -- abre um loop para pegar linha a linha
        loop
            -- faz um fetch
            fetch c_atleta into v_id, v_nome, v_salario;
            -- parada quando não encontrar atleta
            exit when c_atleta%notfound;
            DBMS_OUTPUT.PUT_LINE(v_id || ', ' || v_nome || ', ' || v_salario);
        end loop;
    close c_atleta;
end;

-- Modo 2:
declare
    -- linha de toda tabela
    v_atleta atleta%rowtype;
    cursor c_atleta is
        select * from ATLETA;
begin
    -- abre o cursor
    open c_atleta;
    -- abre um loop para pegar linha a linha
    loop
        -- faz um fetch
        fetch c_atleta into v_atleta;
        -- parada quando não encontrar atleta
        exit when c_atleta%notfound;
        DBMS_OUTPUT.PUT_LINE(v_atleta.ID || ', ' || v_atleta.NOME || ', ' || v_atleta.SALARIO);
    end loop;
    close c_atleta;
end;

-- Modo 3:
-- Cursor com for e declare:
declare
    cursor c_atl5 is
        select id, nome from ATLETA where ID_CLUBE = 11;
begin
    for v_aux in c_atl5 loop
        DBMS_OUTPUT.PUT_LINE(v_aux.ID || ', ' || v_aux.NOME);
    end loop;
end;

-- Modo 4:
-- Cursor com for sem declare:
begin
    for v_aux in (select id, nome from ATLETA where ID_CLUBE = 11) loop
        DBMS_OUTPUT.PUT_LINE(v_aux.ID || ', ' || v_aux.NOME);
    end loop;
end;

-- Exception
-- WHEN DUP_VAL_ON_INDEX
-- WHEN case_not_found
-- WHEN zero_divide then
-- WHEN invalid_number then

-- NO DATA FOUND EXCEPTION:
declare
    v_atleta atleta%rowtype;
begin
    select * into v_atleta from ATLETA where id=4333;
    DBMS_OUTPUT.PUT_LINE(v_atleta.ID || ', ' || v_atleta.NOME);
EXCEPTION
    when NO_DATA_FOUND then
        DBMS_OUTPUT.PUT_LINE('Atleta não encontrado!');
    when TOO_MANY_ROWS then
        DBMS_OUTPUT.PUT_LINE('Consulta retornou mais que um atleta e era esperado somente um!');
end;

-- TOO MANY ROWS EXCEPTION:
declare
    v_atleta atleta%rowtype;
begin
    select * into v_atleta from ATLETA where id_clube=1;
    DBMS_OUTPUT.PUT_LINE(v_atleta.ID || ', ' || v_atleta.NOME);
EXCEPTION
    when NO_DATA_FOUND then
        DBMS_OUTPUT.PUT_LINE('Atleta não encontrado!');
    when TOO_MANY_ROWS then
        DBMS_OUTPUT.PUT_LINE('Consulta retornou mais que um atleta e era esperado somente um!');
end;

-- WHEN OTHERS:
declare
    v_atleta atleta%rowtype;
begin
    select * into v_atleta from ATLETA where id_clube=1;
    DBMS_OUTPUT.PUT_LINE(v_atleta.ID || ', ' || v_atleta.NOME);
EXCEPTION
    when others then
        DBMS_OUTPUT.PUT_LINE('Erro ' || sqlerrm);
end;
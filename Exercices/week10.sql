/*1. Crie uma função chamada
FU_GET_PREMIACAO_ATLETA_PERIODO que receba por
parâmetros o nome de um atleta, uma data inicial e uma
data final, retornando o valor total (arredondado para 2
casas decimais) de premiação ganho por ele nos
campeonatos disputados no período indicado. A data
final poderá ser omitida na execução da função e, nesse
caso, o valor padrão deve ser sysdate. Depois de criada a
função, faça uma consulta para utilizá-la para um atleta já
exista na tabela e um período qualquer que desejar
informando data inicial e data final, e uma outra consulta
para utilizá-la informando apenas o nome do atleta e uma
data inicial, omitindo a data final.*/


SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION fu_get_premiacao_atleta_periodo(
    p_nome_atleta atleta.nome%TYPE,
    p_data_inicial DATE,
    p_data_final DATE DEFAULT SYSDATE
) RETURN NUMBER AS
    v_id_atleta atleta.id%TYPE;
    v_total_horas NUMBER;
BEGIN
    SELECT id INTO v_id_atleta FROM ATLETA WHERE nome = p_nome_atleta;

    SELECT sum(p.valor_premiacao) INTO v_total_horas FROM PARTICIPA p
        JOIN CAMPEONATO c on p.ID_CAMPEONATO = c.ID
        JOIN ESPORTE e ON e.REGISTRO_ATLETA = p.REGISTRO_ATLETA
    WHERE e.ID_ATLETA = v_id_atleta
      and NVL(c.DATA_INICIO,sysdate) >= p_data_inicial
      and NVL(c.DATA_FIM,TO_DATE('01/01/1900', 'dd/mm/yyyy')) <= p_data_final;

    RETURN ROUND(v_total_horas, 2);

END fu_get_premiacao_atleta_periodo;

SELECT fu_get_premiacao_atleta_periodo('Heinrick Samter', TO_DATE('19/07/1995', 'dd/mm/yyyy'), to_date('31/12/2020', 'dd/mm/yyyy')) AS ValorPremiacao FROM dual;
SELECT fu_get_premiacao_atleta_periodo('Heinrick Samter', TO_DATE('19/07/1995', 'dd/mm/yyyy')) ValorPremiacao FROM DUAL;

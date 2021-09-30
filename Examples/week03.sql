
-- ATLETA
desc atleta;
select * from atleta;
select * from clube;
select * from presidente;
select * from olimpico;
select * from paraolimpico;
select nome, sexo from atleta where nome like '%t_';
select nome, salario from atleta where salario between 15000 and 25000;
select cpf, nome from atleta where id_clube is null order by nome;
select id, nome, salario from atleta where salario < 10000 order by salario desc;
select lower(nome), upper(nome), initcap(endereco) from atleta;


-- CLUBE E ATLETA
desc clube;
select concat(concat(nome, ', '), data_fundacao) as nome_fundacao from clube;
select nome || ', ' || data_fundacao as nome_fundacao from clube;
select substr(nome,1,5) from atleta;
select substr(nome, -3, 2) from atleta;
select substr(nome, -3) from atleta;
select length(nome) from atleta;
select salario, round(salario,1), trunc(salario,1) from atleta;
select replace(nome, 'e', 'i') from clube;
select replace(replace(replace(nome, 'a', 'o'), 'e', 'u'), 'i', 'y') from clube;
select translate(nome, 'aei', 'ouy') from clube;
select replace(nome, 'Lawry', 'A') from atleta;
select trim(nome) from atleta where trim(nome) = 'Fabio';
select coalesce(sexo, 'N/D') from atleta;
select nvl(sexo, 'N/D') from atleta;

-- ATLETA
select nome, salario,
  case when salario > 50000 then salario*0.3
       when salario > 25000 then salario*0.2
       when salario > 5000  then salario*0.1
       else 0
  end imposto
  from atleta;
  
select nome, sexo,
  case sexo 
       when 'M' then 'Masculino'
       when 'F' then 'Feminino'
       else 'N/D'
  end sexo
  from atleta;
  
-- FILTRO DECODE
select nome, decode(sexo, 'M', 'Masculino', 'F', 'Feminino', 'N/D') as sexo 
  from atleta;

-- TRATRAMENTO DE DATA E HORA
select sysdate from dual;
select to_char(sysdate, 'dd/mm/yyyy hh:mi am') data_atual from dual;
select to_char(sysdate, 'dd/mm/yyyy hh24:mi:ss') data_atual from dual;
select to_char(sysdate, 'dd-mm-yyyy hh24:mi:ss') data_atual from dual;
select to_char(sysdate, 'dd month yyyy hh24:mi:ss') data_atual from dual;
select to_char(sysdate, 'dd mon yyyy hh24:mi:ss') data_atual from dual;
select to_char(sysdate, 'dy dd mon yyyy hh24:mi:ss') data_atual from dual;
select to_char(sysdate, 'dy dd "de" month "de" yyyy hh24:mi:ss') data_atual from dual;

select to_char(salario, '999990.00')as salario from atleta;
select to_char(salario, '$999,990.00')as salario from atleta;

--AGRUPAMENTOS
select max(salario) from atleta;
select max(salario), min(salario) from atleta;
select sum(salario) from atleta;
select to_char(sum(salario), '9,999,990.00') folha_sal from atleta;
select avg(salario) from atleta;
select to_char(avg(salario), '9,999,990.00') folha_sal from atleta;
select count(*) from atleta;
select count(id_clube) from atleta; -- não contabiliza os valores nulos
select count(*) from atleta where id_clube = 1;

select id_clube, max(salario)
   from atleta
  group by id_clube
  order by id_clube;
  
select id_clube, sexo, round(max(salario),2)
   from atleta
  group by id_clube, sexo
  order by 1, 2;

-- HAVING
select id_clube, round(avg(salario),2)
    from atleta
    group by id_clube
    having avg(salario) > 5000
    order by 1;


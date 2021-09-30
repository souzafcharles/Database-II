-- 1. Liste o valor total de premiação distribuída no campeonato de id 19;
desc pratica;

select to_char(sum(valor_premiacao), '999,990.00') total_premio
    from participa 
    where id_campeonato = 19;
  
-- 2. Encontre a quantidade de atletas que pratica cada modalidade esportiva;
select id_modalidade, count(id_atleta) as qtd_atletas
    from pratica
    group by id_modalidade
    order by 1;
  
-- 3. Liste o id do campeonato e a quantitade de atletas que participam deles,
-- exibindo somento os campeonatos com mais de 3 participantes. Ordene os
-- resultados por quantidade de participantes decrescente;
desc participa;
select id_campeonato, count(*) as qtd_atletas
    from participa
    group by id_campeonato
    having count(*) > 3
    order by qtd_atletas desc;


-- Junções:
select atleta.nome, clube.nome 
   from atleta inner join clube
     on atleta.id_clube = clube.id;

select a.nome, c.nome 
   from atleta a join clube c
     on a.id_clube = c.id;

select a.nome, c.nome 
   from atleta a, clube c
     where a.id_clube = c.id;
     
desc olimpico;
desc paraolimpico;
desc atleta;

-- Listar o nome dos atletas olimpicos e se eles tem ou não incentivo do governo:
select a.nome, o.incentivo_governo
   from atleta a join olimpico o
    on a.id = o.id_atleta;
    
select a.nome, o.incentivo_governo
   from atleta a join olimpico o
    on a.id = o.id_atleta
        and a.id_clube in (24,29);

select a.id_clube ,a.nome, o.incentivo_governo
   from atleta a, olimpico o
  where a.id = o.id_atleta
   and a.id_clube in (24,29);
        
select c.nome ,a.nome, o.incentivo_governo
   from atleta a join olimpico o
     on o.id_atleta = a.id
   join clube c on a.id_clube = c.id
    and a.id_clube in (24,29);
    
-- Outer Join
-- left outer join considera os nulos da tabela da esquerda do join
select a.nome, c.nome 
   from atleta a left outer join clube c
     on a.id_clube = c.id;

-- outra forma de dar left outer join
select a.nome, c.nome 
   from atleta a join clube c
     on a.id_clube = c.id (+); 
     
-- rigth considera os nulos da tabela da direita
select a.nome, c.nome 
   from atleta a right outer join clube c
     on a.id_clube = c.id;
     
select a.nome, c.nome 
   from atleta a join clube c
     on a.id_clube (+) = c.id;
     
-- Full outer joint: traz as seleçoes tanto do left quanto do right
select a.nome, c.nome 
   from atleta a full outer join clube c
     on a.id_clube = c.id;
     
-- Liste os ids e descrições das modalidades e os nomes dos atletas que as praticam:
desc modalidade;
desc pratica;
desc atleta;

select m.id, m.descricao, a.nome
   from atleta a join pratica p
     on a.id = p.id_atleta
   join modalidade m on m.id = p.id_modalidade
   order by m.id;
   
-- Liste o nome, data de início e data de término dos campeonatos e o registro
-- de atletas que participaram dele, se houver (inlcuir na listagem campeonatos
-- que ninguém participou)

desc campeonato;
desc participa;

select c.nome, c.data_inicio, c.data_fim, p.registro_atleta
   from campeonato c left outer join participa p
     on c.id = p.id_campeonato
   where c.data_inicio is not null;
-- 1.1. Buscar todos os registros da tabela usuario_cadsus
select 
    * 
from 
	usuario_cadsus
;

-- 1.2. Busque todos os registros da tabela com codigo de usuario e nome do usuario

select 
cd_usu_cadsus,
nm_usuario

from 
	usuario_cadsus
;

-- 1.3 encontre o registro do seu nome na tabela usuario_cadsus, com todas as colunas

select *

from 
	usuario_cadsus
	
where
    nm_usuario = 'ALEX PEDRO GONCALVES SEBASTIAO'
;

-- 1.4. BUSQUE TODOS OS TELEFONES REGISTRADOS NO SEU CADASTRO

select 
	nm_usuario,
	nr_telefone,
	nr_telefone_2,
	celular,
	telefone3,
	telefone4
	
from 
	usuario_cadsus
	
where
    nm_usuario = 'ALEX PEDRO GONCALVES SEBASTIAO'
;

-- 1.5. BUSQUE TODOS OS REGISTRO DA TABELA EM QUE A CIDADE DE NASCIMENTO TENHA CODIGO 430470

select *
	
from 
	usuario_cadsus
	
where
    cd_municipio_residencia = 430470
;

-- 1.6. ENCONTRE O REGITRO DE TODOS OS PACIENTES JOÃO DA SILVA. EXIBA NOME E DATA DE NASCIMENTO NUMA MESMA COLUNA CHAMADA NOME-DN. COMENTE O CODIGO

select 
	nm_usuario ||' - ' ||
	dt_nascimento as dd_basic
	
from 
	usuario_cadsus
	
where
    nm_usuario = 'JOAO DA SILVA'
-- não esquecer que select é coluna,from é tabela e where condição de filtro    
;


-- 1.7. BUSQUE O NOME DE PESSOAS QUE NASCERAM NO MESMO DIA QUE VOCÊ. PROECURE SE ALGUMA DELAS POSSUI O PRIMEIRO NOME QUE VOCÊ, DEPOS DESATIVE ESSE TERECO DO CODIGO

select 
	nm_usuario ||' , '|| dt_nascimento as nome_dn
	 
	
from 
	usuario_cadsus
	
where
    nm_usuario like '%ALEX %' 
   -- and dt_nascimento = '1981-06-23'::date 
   -- não esquecer do and ou or
;

-- 1.8. BUSQUE NOME E A DATA DE NASCIMENTO DE 20 PESSOAS COM O PRIMEIRO NOME JULIANA, JULLIANA, JULIANE OU JULLIANE.

select 
	nm_usuario ||' , '|| dt_nascimento as nome_dn
	 
	
from 
	usuario_cadsus
	
where
    nm_usuario like 'JULIANA %'
    or nm_usuario like 'JULLIANA%'or nm_usuario like 'JULIANE %'or nm_usuario like 'JULLIANE %'

limit 20
-- NÃO ESQUECER DE EM WHERE REPETIR TODA CONDIÇÃO + A VARIAVEL
;

-- 1.9. BUSQUE O NOME E O CPF DAS PESSOAS QUE ESTÃO CADASTRADAS COM O PRIMEIRO NOME ALEX E UM DOS SOBRENOME SANTOS, QUE TENHAM CPF.CLASSIFIQUE EM ORDEM ALFABETICA

select 
	nm_usuario ||' , '|| cpf as nome_cpf
	 
	
from 
	usuario_cadsus
	
where
    nm_usuario like 'ALEX % SANTOS %' and
    cpf is not null  
    and cpf != ''
order by nm_usuario asc
    

limit 20
;
-- 1.10. BUSQUE O REGISTRO COMPLETO DE 20 PESSOAS DO SEXO FEMININO QUE NASCERAM APÓS 2000 E NÃO NASCERAM EM FLORIANOPOLIS (420540). CLASSIFIQUE DA MAIS NOVA PARA MAIS VELHA.

select *
	 
	
from 
	usuario_cadsus
	
where
    sg_sexo = 'F' 
    and cod_cid_nascimento != 420540
    and dt_nascimento >= '2000-01-01'::date
order by nm_usuario desc
    

limit 20
;

-- 1.11. BUSQUE O NOME E A DATA DE NASCIMENTO DE 30 PESSOAS DO SEXA MASCULINO QUE NASCERAM ANTES DE 1930 OU ENTRE 1990 E 2000.

select *
	 
	
from 
	usuario_cadsus
	
where
    sg_sexo = 'M' 
    and cod_cid_nascimento != 420540
    and (dt_nascimento < '1930-01-01'::date
    	or dt_nascimento between '1990-01-01'::date and '2000-01-01'::date)
-- prestar atenção no uso de () no exemplo acima or fica condicionado de ntro do ()
    

limit 30
;

--1.12. BUSQUE O NOME DE 50 PESSOAS QUE FORAM CADASTRADAS ANTES 2020 E SEM CPF

select 
	nm_usuario,
	dt_cadastro::date as data_cd,
	cpf
	
	 
	
from 
	usuario_cadsus
	
where
   	dt_cadastro < '2019-12-31'::date and
    cpf is null
    

    

limit 50
;


--1.13. GERE UMA LISTA COM OS DIFERENTES CODIGOS DOS PAISES NASCIMENTO

select 
	distinct cd_pais_nascimento	
	
	 
	
from 
	usuario_cadsus
	

   	
    

    

limit 50
;

--1.14. busque os pacientes cadastrados pelos profissionais com código 7455,381,9484,216

select 
	nm_usuario,	
	cd_usuario_cad
	 
	
from 
	usuario_cadsus
	
where
	cd_usuario_cad in (7455,9484,381,216)
	order by cd_usuario_cad asc
   	
    

    

limit 200

;

--1.15./ 1.16. Encontre o nome e data de nascimento do paciente mais velho/novo cadastro.

select 
	nm_usuario,	
	dt_nascimento
	 
	
from 
	usuario_cadsus
	
	
order by 
	--dt_nascimento asc mais velho
	dt_nascimento desc -- mais novo
   	
    

    

limit 200

;

--1.17. Conte quantas pessoas cadastradas após 2020 não possuem CPF

select 
	count(*) as pessoas_sem_cpf
 	
	
from 
	usuario_cadsus
	
where
	dt_cadastro < '2019-12-31'::date
	and (cpf is null
	or cpf = '') 


;

--1.18.Conte quantas pessoas cadastradas após 2020 não possuem CPF e sem RG

select 
	count(*) as pessoas_sem_cpf
 	
	
from 
	usuario_cadsus
	
where
	dt_cadastro < '2019-12-31'::date
	and (cpf is null
	or cpf = '') and (rg is null or rg = '')


;

--1.19. liste o nome e data de nascimento das pessoas sem CPF cadastradas noa ultimos 6 meses

select 
	nm_usuario,
	dt_nascimento,
	dt_cadastro::date
 	
	
from 
	usuario_cadsus
	
where
	(cpf is null or cpf = '')
	and dt_cadastro >= (current_date - '6 months'::interval)
	--and dt_cadastro between (current_date - '6 months'::interval) and current_date
	
order by dt_cadastro desc
limit 50
;

--1.20. liste o nome de 50 pessoas com o número de celular. caso não tenha celular registrado, o resultado deverá exibir " sem "celular.

select 
	nm_usuario,
	case
		when celular is not null then celular
		when celular is null then 'sem celular'
	end as num_celular
from 
	usuario_cadsus
limit 50
;


-- case when then end (caso, quando, então, fim)
;

--1.21. Busque nome de 50 pessoas atendidas no dia atual

select
	uc.nm_usuario,
	atd.cd_cbo
from
	usuario_cadsus uc
	join atendimento atd on uc.cd_usu_cadsus = atd.cd_usu_cadsus
where
	atd.dt_atendimento::date = current_date
limit 50;

--1.22. busque o nome de usuario atendido pelo profissional 262582, após 01/01/2022 ou no mês de agosto de 2021.

select
	uc.nm_usuario,
	atd.dt_atendimento::date
	
from
	usuario_cadsus uc
	join atendimento atd on uc.cd_usu_cadsus = atd.cd_usu_cadsus
	
where
	atd.cd_profissional in (262582) and (atd.dt_atendimento > '2022-01-01'::date
    	or atd.dt_atendimento between '2021-08-01'::date and '2021-08-31'::date)

--1.23. busque o codigo de prontuario das crianças de 0 a 10 anos atendidas pelo profissional 262582 nos ultimos 20 dias.

select
	uc.cd_usu_cadsus,
	uc.dt_nascimento,
	extract(year from age(dt_nascimento)) as idade,
	atd.cd_profissional,
	atd.dt_atendimento::date
from
	usuario_cadsus uc
	join atendimento atd on uc.cd_usu_cadsus = atd.cd_usu_cadsus
	
where
	--atd.cd_profissional = 262582 
	atd.dt_atendimento >= (current_date - '20 days'::interval)
	and age(uc.dt_nascimento) <= '10 year' 
	-- ou prederia ser assim extract(year from age(dt_nascimento)) <= 10
order by atd.dt_atendimento asc
	
limit 200
;

-- ou assim

select
	uc.cd_usu_cadsus,
	--uc.dt_nascimento,
	extract(year from age(uc.dt_nascimento)) as idade
	--atd.cd_profissional,
	--atd.dt_atendimento::date
from
	usuario_cadsus uc
	join atendimento atd on uc.cd_usu_cadsus = atd.cd_usu_cadsus
	
where
	--atd.cd_profissional = 262582 
	atd.dt_atendimento >= (current_date - '20 days'::interval)
	and age(uc.dt_nascimento) <= '10 year' 

order by uc.dt_nascimento desc

	
limit 200
;

--1.24 Liste o nome de pessoas atendidas nos ultimos 7 dias com cid B972.

select
	uc.nm_usuario,
	atd.dt_atendimento::date,
	cd_cid_principal
from
	usuario_cadsus uc
	join atendimento atd on uc.cd_usu_cadsus = atd.cd_usu_cadsus
	
where
	atd.dt_atendimento >= (current_date - '7 days'::interval)
	and cd_cid_principal ='B972'

order by 
	atd.dt_atendimento::date asc, -- dt_atendimento é timestamp logo as horas contariam para ordenação usando o date isso é corrigido
	uc.nm_usuario asc
	
limit 200
;

--1.25. liste o numero de códigos dos atendimentos realizados hoje na unidade 257617, com CPF do usario se houver.

select
	uc.nm_usuario,
	uc.celular,
	uc.nr_telefone,
	--(atd.dt_chegada - atd.dt_atendimento) as minutos,
	extract(epoch from (atd.dt_chegada - atd.dt_atendimento) / 60) as minutos,
	atd.dt_atendimento
from
	usuario_cadsus uc	
	join atendimento atd on uc.cd_usu_cadsus = atd.cd_usu_cadsus

where
	atd.dt_atendimento::date = current_date 
	and (atd.dt_chegada - atd.dt_atendimento)::interval > '1 hour'::interval

order by minutos asc
limit 200;

--1.26. liste o numero do codigo de atendimentos realizados hpje na unidade 257617, com CPF do usuario se houver 

select

	atd.nr_atendimento,
	uc.cpf,
	atd.empresa
from
	usuario_cadsus uc
	join atendimento atd on uc.cd_usu_cadsus = atd.cd_usu_cadsus
	
where
	atd.dt_atendimento::date = current_date 
	and (uc.cpf is not null or uc.cpf <> '')	
	and atd.empresa = 257617
	
order by 
	
	atd.dt_atendimento desc
	
limit 200
;

--1.27. 

select
	uc.nm_usuario,
	count(nm_usuario)
	
	
	
from
	usuario_cadsus uc
	join atendimento atd on uc.cd_usu_cadsus = atd.cd_usu_cadsus
	
where 
	(uc.nm_usuario like 'MARIA DA SILVA %' or uc.nm_usuario like '% MARIA DA SILVA %') 
	
group by 
	uc.nm_usuario
	
	

limit 10

--1.31. busque o codigo de atendimento dos atendimentos realizados no dia atual no cs Prainha.

select
	atd.nr_atendimento,
	count(atd.nr_atendimento) as tot_al,
	atd.dt_atendimento::date,
	cs.descricao
from
	usuario_cadsus uc
	 join empresa cs on cs.empresa = empresa_responsavel
	 join atendimento atd on uc.cd_usu_cadsus = atd.cd_usu_cadsus
where
	atd.dt_atendimento::date = current_date and
	cs.descricao = 'CS PRAINHA'
group by
	atd.nr_atendimento,
	cs.descricao,
	atd.dt_atendimento
;

--1.32. busque o nome e data de nascimento dos pacientes atendidos no dia anterior no cs sacodoslimoes.

select
	uc.nm_usuario,
	uc.dt_nascimento,
	cs.descricao,
	atd.dt_atendimento
	
from usuario_cadsus uc
	join empresa cs on cs.empresa = empresa_responsavel
	join atendimento atd on uc.cd_usu_cadsus = atd.cd_usu_cadsus
	
where
	atd.dt_atendimento::date = current_date - interval '1 day'
	and cs.descricao = 'CS SACO DOS LIMOES'
order by uc.dt_nascimento asc
limit 50

;

--1.33. Busque a lista de pacientes atendidos em janeiro na CS COSTA DA LAGOA, indicando se o paciente possui ou não CPF ( utilize 1 para sim e 0 para não).

select
	uc.nm_usuario,
	--uc.dt_nascimento,
	cs.descricao,
	--atd.dt_atendimento,
	case
		when atd.cpf notnull then 0
		else 1
		end situacao_cpf

from usuario_cadsus uc
	join empresa cs on cs.empresa = empresa_responsavel
	join atendimento atd on uc.cd_usu_cadsus = atd.cd_usu_cadsus
	
where
	atd.dt_atendimento between '2022-01-01'::date and '2022-01-31'::date
	and cs.descricao = 'CS COSTA DA LAGOA'
	
order by uc.nm_usuario asc
;

--1.34.	busque o numero de atendimentos realizados po CS NO DIA 03/01/2022

select
	cs.descricao,
	count(cs.descricao)as soma

from usuario_cadsus uc
	join empresa cs on cs.empresa = empresa_responsavel
	join atendimento atd on uc.cd_usu_cadsus = atd.cd_usu_cadsus
	
where
	atd.dt_atendimento::DATE = '2022-01-03'
	and cs.descricao like 'CS %'
	
group by 
	cs.descricao
order by soma asc
;

--1.35. busque a lista de pacientes atendidos realizados por profissional médico no dia atual no Cs CENTRO

select
	uc.nm_usuario,
	uc.dt_nascimento,
	cs.descricao,
	atd.dt_atendimento::date,
	tc.ds_cbo,
	case
		when atd.cpf notnull then 0
		else 1
		end situacao_cpf

from usuario_cadsus uc
	join empresa cs on cs.empresa = empresa_responsavel
	join atendimento atd on uc.cd_usu_cadsus = atd.cd_usu_cadsus
	join tabela_cbo tc on tc.cd_cbo = atd.cd_cbo
	
where
	atd.dt_atendimento::DATE = current_date
	and cs.descricao = 'CS CENTRO'
	and atd.cd_cbo like '225%'
	
order by uc.nm_usuario asc
;

-- ou

select
	uc.nm_usuario,
	uc.dt_nascimento,
	cs.descricao,
	atd.dt_atendimento::date,
	tc.ds_cbo,
	case
		when atd.cpf = '' then 0
		else 1
		end situacao_cpf

from usuario_cadsus uc
	join empresa cs on cs.empresa = empresa_responsavel
	join atendimento atd on uc.cd_usu_cadsus = atd.cd_usu_cadsus
	join tabela_cbo tc on tc.cd_cbo = atd.cd_cbo
	
where
	atd.dt_atendimento::DATE = current_date
	and cs.descricao = 'CS CENTRO'
	and atd.cd_cbo like '225%'
	
order by atd.cpf desc
;

--1.41. Use a função concat  para concatenar nome e data de nascimento de um usuario

select
	concat(
		uc.nm_usuario,'//',
		uc.dt_nascimento)


from usuario_cadsus uc
	
	
order by uc.nm_usuario asc

limit 50
;


--1.42 Use a função concat_ws  para concatenar nome,data de nascimento e CPF de um usuario, separados por vircula

select
	concat_ws(',',
	nm_usuario,
	dt_nascimento, cpf)
	

from usuario_cadsus
	
where
	cpf is not null

	
order by nm_usuario asc

limit 50
;
		
-- 1.43. Busque o seu nome e altere para a primeira letra maiuscula e demais miniuculas, com o initcap. depois altere para todas maiusculas e todas minusculas, com upper  e lower

/*select
	initcap(nm_usuario) as usuario
from
	usuario_cadsus
where
	nm_usuario ='ALEX PEDRO GONCALVES SEBASTIAO'

;*/

/*select
	lower(nm_usuario) as usuario
from
	usuario_cadsus
where
	nm_usuario ='ALEX PEDRO GONCALVES SEBASTIAO'
;*/

select
	upper(nm_usuario) as usuario
from
	usuario_cadsus
where
	nm_usuario ='ALEX PEDRO GONCALVES SEBASTIAO'
;

-- 1.44. Busque 10 pacientes do sexo masculino e classifique de forma descendente pelo tamanho do nome

select
	length (nm_usuario) as nome,
	nm_usuario,
	sg_sexo
from
	usuario_cadsus
where
	sg_sexo = 'M' 
order by nome desc

limit 10
;

--1.45. calcule a média de atendimentos de um profissional nos ultimos 3 dias. teste as funções CEIL, FLOOR e ROUND para arrendodar o resultado.

select
	count(pf.nm_profissional)/3 as media_nos_ultimos_3_dias,
	pf.nm_profissional
	
from
	atendimento atd
	join profissional pf on atd.cd_profissional = pf.cd_profissional
where
	atd.dt_atendimento::date >= (current_date - '3 days'::interval)
	and pf.nm_profissional like 'zelma gulart de lima'
group by
	pf.nm_profissional
	 
order by pf.nm_profissional desc
;-- corrigir com o denis não consegui usar o AGE

--1.46. Selecione um timestamp e utilize o date_trunc para obter o inicio do mês

select
	nm_usuario,
	date_trunc('month',dt_inclusao)
from
	usuario_cadsus
;
--1.47. utilize a função age para saber sua idade e transforme em anos, meses , dias e minutos utilizando a função extract

select
	nm_usuario,
--	extract( day from dt_nascimento)
--	extract( month from dt_nascimento)
--	extract( year from dt_nascimento)
--	extract( hour from dt_nascimento)
--	extract( decade from dt_nascimento)
--	extract( dow from dt_nascimento)
extract (year from age(dt_nascimento))
from
	usuario_cadsus
where
	nm_usuario like 'ALEX PEDRO GONCALVES SEBASTIAO'
;

--1.48. Busque o ultimo horário de atendimento em cada CS no dia de ontem e verefique qual teve o ultimo atendimento (mais tarde).repita a busca usando o primeiro horario de atendimento

select
ep.descricao,	
max(atd.dt_atendimento::time) as ultimo
--min(atd.dt_atendimento::time) as primeiro	
from
	atendimento atd
	join empresa ep on atd.empresa = ep.empresa		
where
	ep.descricao like 'CS %' 
	and atd.dt_atendimento::date = current_date - interval '1 day'
group by	
	ep.descricao
order by ultimo asc
--order by primeiro asc
;

	

	
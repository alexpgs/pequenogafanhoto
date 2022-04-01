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


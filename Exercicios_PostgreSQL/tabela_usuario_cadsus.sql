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

;


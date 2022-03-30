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


select
	nm_usuario,replace (replace (replace (replace (replace (nm_usuario,'A',''),'E',''),'I',''),'O',''),'U','') as resultado
from
	usuario_cadsus
limit 5
-- Para pesquisar e substituir todas as ocorrências de uma string por uma nova, você usa a  REPLACE() função.

select
	distinct(tc.ds_cbo),
	pf.nm_profissional
from
	atendimento atd
	join profissional pf on pf.cd_profissional = atd.cd_profissional
	join tabela_cbo tc on tc.cd_cbo = atd.cd_cbo
where
	atd.cd_cbo = '131210'
group by 
	tc.ds_cbo,
	pf.nm_profissional

-- cargo e nome
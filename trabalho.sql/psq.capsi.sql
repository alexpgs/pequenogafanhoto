select 
	atd.nr_atendimento /3 -5 as id,
	extract(month from atd.dt_atendimento)::text||'/'||extract(year from
    atd.dt_atendimento)::text as mês_ano,
	eed.descricao as distrito,
	atd.cd_cbo as cbo,
	tb.ds_cbo as Profissão
from 
	atendimento atd
	join empresa ep on atd.empresa = ep.empresa
	join usuario_cadsus uc on atd.cd_usu_cadsus = uc.cd_usu_cadsus
	left join endereco_usuario_cadsus euc on uc.cd_endereco = euc.cd_endereco
	left join endereco_estruturado ee on euc.cd_endereco_estruturado = ee.cd_endereco_estruturado
	left join end_estruturado_distrito eed on ee.cd_end_estruturado_distrito = eed.cd_end_estruturado_distrito
	left join tabela_cbo tb on atd.cd_cbo = tb.cd_cbo
where
	atd.empresa = 195959 
	and atd.cd_cbo <> '131210' and atd.cd_cbo <> '225112' and atd.cd_cbo <> '411010'
	and atd.dt_atendimento::date >= '2021-01-01'
	
	
	
order by 1 desc ;
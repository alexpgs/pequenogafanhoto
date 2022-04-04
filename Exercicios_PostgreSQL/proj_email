select
	uc.nm_usuario,
	vc.ds_vacina,
	vc.cd_doses,
	uc.dt_nascimento,
	uc.nm_mae,
	cs.descricao,
	ed.nm_logradouro,ed.nr_logradouro,ed.nm_bairro,
	uc.nr_telefone,uc.celular,uc.telefone3,uc.telefone4
from usuario_cadsus uc
	left join empresa cs on cs.empresa = empresa_responsavel
	left join vac_aplicacao vc on uc.cd_usu_cadsus = vc.cd_usu_cadsus
	left join endereco_usuario_cadsus ed on ed.cd_endereco = uc.cd_endereco
	
where
	vc.cd_vacina is not NULL AND-- (349982869,412381369,349982877,349982865,349982873) and
	uc.nm_usuario = 'ARTUR CHINI SEBASTIAO'
	
/*	and uc.dt_nascimento <= (current_date - '5 year'::interval)
	and age(uc.dt_nascimento) <= '11 year'
	and vc.cd_doses isnull*/
order by uc.dt_nascimento asc


;
		
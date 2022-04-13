select
	distinct(va.dt_aplicacao),
	uc.nm_usuario,
	va.ds_vacina,
	va.dt_aplicacao,
	vc.doses,
	uc.dt_nascimento,
	uc.nm_mae,
	cs.descricao,
	uc.nr_telefone,uc.celular,uc.telefone3,uc.telefone4,
	ed.nm_logradouro,ed.nr_logradouro,ed.nm_bairro
	
from usuario_cadsus uc
	 join empresa cs on cs.empresa = empresa_responsavel
	 join vac_aplicacao va on uc.cd_usu_cadsus = va.cd_usu_cadsus
	 join endereco_usuario_cadsus ed on ed.cd_endereco = uc.cd_endereco
	 join vac_calendario vc on va.cd_vacina = vc.cd_vacina 
		
	
where
	va.cd_vacina not in  (349982869,412381369,349982877,349982865,349982873) and
	 uc.dt_nascimento <= (current_date - '5 year'::interval)
	and age(uc.dt_nascimento) <= '11 year'
	
order by uc.dt_nascimento desc

limit 50
		
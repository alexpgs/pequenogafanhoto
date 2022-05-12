select
	atd.nr_atendimento *2/100,
	extract(year from age(atd.dt_atendimento,uc.dt_nascimento)) as idade,
	uc.sg_sexo,
	dt.nm_dente as dente,
	std.ds_situacao as motivo,
	aoe.ds_trabalho as prontuario_reg,
	atd.dt_atendimento::date as data_atendimento,
	atd.dt_atendimento ::time as hora_atendimento,
	ea.ds_area as area,
	(case  when ep.descricao = 'UNIDADE DE PRONTO ATENDIMENTO - UPA SUL DA ILHA' then 'UPA SUL' else 'UPA NORTE' end) as upa
	
	
	

from 
	atendimento atd
	join empresa ep on ep.empresa = atd.empresa
	join usuario_cadsus uc on uc.cd_usu_cadsus = atd.cd_usu_cadsus
	left join atendimento_odonto_plano aop on aop.nr_atendimento = atd.nr_atendimento
	left join dente dt on dt.cd_dente = aop.cd_dente
	left join situacao_dente std on std.cd_situacao = aop.cd_situacao
	left join atendimento_odonto_execucao aoe on aoe.cd_atendimento_plano = aop.cd_atendimento_plano
	join endereco_usuario_cadsus euc on euc.cd_endereco = atd.cd_endereco
	left join endereco_estruturado ee on ee.cd_endereco_estruturado = euc.cd_endereco_estruturado
	left join equipe_micro_area ema on ema.cd_eqp_micro_area = ee.cd_eqp_micro_area
	left join equipe_area ea on ea.cd_equipe_area = ema.cd_equipe_area
	
	

where
	atd.dt_atendimento between '2020-12-01'::date and '2020-12-31'::date
	and extract(year from age(atd.dt_atendimento,uc.dt_nascimento)) <= 6
	and ep.descricao like '%UNIDADE DE PRONTO ATENDIMENTO%'
	and atd.cd_cbo like '2232%'
	
;
	

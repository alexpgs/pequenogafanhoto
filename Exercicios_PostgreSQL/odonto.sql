select
	(case  when ep.descricao = 'UNIDADE DE PRONTO ATENDIMENTO - UPA SUL DA ILHA' then 'UPA SUL' else 'UPA NORTE' end) as unidade,
	atd.dt_atendimento::date as data_atendimento,
	atd.dt_atendimento ::time as hora_atendimento,
	(atd.nr_atendimento *2 -357) as cod_atendimento,
	(uc.cd_usu_cadsus *2 -357) as cod_usuario,
	extract(year from age(atd.dt_atendimento,uc.dt_nascimento)) as idade,
	uc.sg_sexo as sexo,
	dt.nm_dente as dente,
	std.ds_situacao as motivo,
	--aoe.ds_trabalho as evolucao,
	ea.ds_area as equipe,
	euc.nm_bairro as bairro,
	c.descricao as cidade
		
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
	join cidade c on uc.cd_municipio_residencia = c.cod_cid 
where
	atd.dt_atendimento between '2019-01-01'::date and '2022-05-12'::date
	and extract(year from age(atd.dt_atendimento,uc.dt_nascimento)) <= 6
	and ep.descricao like '%UNIDADE DE PRONTO ATENDIMENTO%'
	and atd.cd_cbo like '2232%'

;
	

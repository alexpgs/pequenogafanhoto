select
	ta.ds_tipo_atendimento,	
	atd.cd_cid_principal,
	count(atd.nr_atendimento) as total_atendimentos,
	sum(case when extract(year from age(atd.dt_atendimento,uc.dt_nascimento)) <= 14 then 1 else 0 end) as total_ate_14a
	--extract(year from age(atd.dt_atendimento,uc.dt_nascimento)) as idade
from 
	atendimento atd
	join usuario_cadsus uc on uc.cd_usu_cadsus = atd.cd_usu_cadsus
	join empresa ep on atd.empresa = ep.empresa
	join natureza_procura_tp_atendimento ntp on atd.cd_nat_proc_tp_atendimento = ntp.cd_nat_proc_tp_atendimento
	left join tipo_atendimento ta on ntp.cd_tp_atendimento = ta.cd_tp_atendimento
where
	atd.dt_atendimento between '2019-03-01'::date and '2020-02-28'::date
	and ep.descricao = 'CCV - POLICLÍNICA CONTINENTE'
	--and ds_tipo_atendimento like '%RETINA%' or ds_tipo_atendimento like '%CATARATA%' or ds_tipo_atendimento like '%GLAUCO%'

group by 1,2

order by 4 asc

	
	;
select 
	to_char(icp.data_lancamento,'mm-yyyy') as competencia,
	atd.dt_atendimento::date as atendimento,
	uc.nm_usuario,
	uc.dt_nascimento,
	p.ds_procedimento
	--p.referencia,
	--count(icp.*)
	--extract(month from icp.data_lancamento) as mes
from 
	atendimento atd
	join item_conta_paciente icp on icp.nr_atendimento = atd.nr_atendimento 
	join empresa em on atd.empresa = em.empresa
	join procedimento p on p.cd_procedimento = icp.cd_procedimento
	join usuario_cadsus uc on atd.cd_usu_cadsus = uc.cd_usu_cadsus
 
where 
	icp.data_lancamento between '2021-04-01'::date and '2021-04-30'::date
	and em.empresa = 4272619
	--and ds_procedimento = 'ATENDIMENTO MEDICO EM UNIDADE DE PRONTO ATENDIMENTO'
--group by 1,2,3


--


select 
	to_char(icp.data_lancamento,'mm-yyyy') as mes_2021,
	p.ds_procedimento,
	p.referencia,
	count(icp.*)
	--extract(month from icp.data_lancamento) as mes
from 
	atendimento atd
	join item_conta_paciente icp on icp.nr_atendimento = atd.nr_atendimento 
	join empresa em on atd.empresa = em.empresa
	join procedimento p on p.cd_procedimento = icp.cd_procedimento 
 
where 
	icp.data_lancamento between '2021-01-01'::date and '2021-12-31'::date
	and em.empresa = 4272619
	--and ds_procedimento = 'ATENDIMENTO MEDICO EM UNIDADE DE PRONTO ATENDIMENTO'
group by 1,2,3
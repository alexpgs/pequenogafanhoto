select
	count(icp.cd_procedimento) as total_atendimento,
	extract(month from atd.dt_atendimento)::text||'/'||extract(year from  atd.dt_atendimento)::text as mês_ano,
    pc.ds_procedimento as Procedimento,
	pf.nm_profissional as Profissional
	
from
 item_conta_paciente icp
 join procedimento pc on icp.cd_procedimento = pc.cd_procedimento
 left join empresa ep on icp.empresa_faturamento = ep.empresa
 join atendimento atd on icp.nr_atendimento = atd.nr_atendimento
 join profissional pf on icp.cd_profissional = pf.cd_profissional
where 
	atd.dt_atendimento::date between '2021-01-01'::date and '2021-12-31'::date 
	and ep.descricao like '%CS%' 
	and icp.cd_cbo in ('225142','225130','225125','225170') 
	and icp.cd_procedimento in (45,
	1152,
	1157,
	1159,
	4875,
	4876,
	1468,
	1876,
	1900,
	4686,
	4847)
group by 2,3,4;

-- tem 30.000 resultados a mais

-- ou --

-- tem 30.000 resultados a menos

select
	extract(month from atd.dt_atendimento)::text||'/'||extract(year from  atd.dt_atendimento)::text as mês_ano,
    count(atd.nr_atendimento) as total_atendimento,
	pc.ds_procedimento as Procedimento,
	pf.nm_profissional as Profissional
from
	atendimento atd
	left join procedimento pc on atd.cd_procedimento = pc.cd_procedimento
	left join profissional pf on atd.cd_profissional = pf.cd_profissional 
	left join empresa ep on atd.empresa = ep.empresa
	
	
where
	atd.dt_atendimento::date between '2021-01-01'::date and '2021-12-31'::date
	and ep.descricao like '%CS%'
	and atd.cd_cbo in ('225142','225130','225125')
	and pc.referencia in ('0301040141','0301040150','0303080019','0401010066','0401020177',
						'0101030029','4686','0301010137','4847','0301010064','0301010110')
group by 
		1,3,4
;
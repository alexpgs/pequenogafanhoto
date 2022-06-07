select -- violencia a mulher
	count (atd.nr_atendimento) as numero_atendimentos,
	cc.descricao,
	cd.cd_cid,
	cd.nm_cid
	--extract(year from age(uc.dt_nascimento::date))
	
from 
	item_conta_paciente icp
	join cid cd on icp.cd_cid = cd.cd_cid
	join cid_classificacao cc on cd.cd_classificacao = cc.cd_classificacao
	join conta_paciente ctp on icp.cd_conta_paciente = ctp.cd_conta_paciente
	join usuario_cadsus uc on ctp.cd_usu_cadsus = uc.cd_usu_cadsus
	join atendimento atd on icp.nr_atendimento = atd.nr_atendimento
	
where
	cc.cd_classificacao in (279468389,42,43,279472004)
	and uc.sg_sexo like 'F'
	and atd.dt_atendimento::date between '2022-01-01'::date and '2022-12-31'::date
group by 2,3,4
;	
--

select -- violencia a menor de 18 anos
	count (atd.nr_atendimento) as numero_atendimentos,
	extract(year from age(uc.dt_nascimento::date)) as idade,
    uc.sg_sexo as sexo,
    cc.descricao as classificacao,
	cd.cd_cid as cid,
	cd.nm_cid as descricao
	
	
from 
	item_conta_paciente icp
	join cid cd on icp.cd_cid = cd.cd_cid
	join cid_classificacao cc on cd.cd_classificacao = cc.cd_classificacao
	join conta_paciente ctp on icp.cd_conta_paciente = ctp.cd_conta_paciente
	join usuario_cadsus uc on ctp.cd_usu_cadsus = uc.cd_usu_cadsus
	join atendimento atd on icp.nr_atendimento = atd.nr_atendimento
	
where
	cc.cd_classificacao in (279468389,42,43,279472004)
	and extract(year from age(uc.dt_nascimento::date)) < '18'
	and atd.dt_atendimento::date between '2022-01-01'::date and '2022-12-31'::date
group by 2,3,4,5,6
;
	
--
select -- intoxicações
count (atd.nr_atendimento) as numero_atendimentos,
	extract(year from age(uc.dt_nascimento::date)) as idade,
    uc.sg_sexo as sexo,
    cc.descricao as classificacao,
	cd.cd_cid as cid,
	cd.nm_cid as descricao
	
	
from 
	item_conta_paciente icp
	join cid cd on icp.cd_cid = cd.cd_cid
	join cid_classificacao cc on cd.cd_classificacao = cc.cd_classificacao
	join conta_paciente ctp on icp.cd_conta_paciente = ctp.cd_conta_paciente
	join usuario_cadsus uc on ctp.cd_usu_cadsus = uc.cd_usu_cadsus
	join atendimento atd on icp.nr_atendimento = atd.nr_atendimento
	
where
	cd.nm_cid ilike '%intoxica%'
	and extract(year from age(uc.dt_nascimento::date)) between '15' and '29'
	and atd.dt_atendimento::date between '2022-01-01'::date and '2022-12-31'::date
group by 2,3,4,5,6
;
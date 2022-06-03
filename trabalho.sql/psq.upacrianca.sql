select 
	ep.descricao,
	extract(year from age(uc.dt_nascimento)) as idade,
	count(atd.nr_atendimento) as num_atendimentos,
	count(distinct atd.cd_usu_cadsus) as num_criancas
from
	atendimento atd
	join usuario_cadsus uc on atd.cd_usu_cadsus = uc. cd_usu_cadsus
	join empresa ep on atd.empresa = ep.empresa
where
	atd.dt_atendimento::date between '2022-05-01'::date and '2022-05-31'
	and age(uc.dt_nascimento) <= '14 year' 
	and ep.descricao like '%UPA%'
	and atd.cd_cbo similar to '(225|2231)%'
group by 1,2
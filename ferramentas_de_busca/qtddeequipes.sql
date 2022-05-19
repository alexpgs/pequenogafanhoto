
select
	ep.descricao,
	count(eq.nm_referencia)

	 
	
from 
	 equipe eq
	 join empresa ep on eq.empresa = ep.empresa
where 
	eq.cd_tp_equipe IN ('70','76') -- filtra por ESF - EQUIPE DE SAÚDE DA FAMÍLIA E eAP - EQUIPE DE ATENÇÃO PRIMARIA (AINFA HÁ...,71,72)
	and ep.descricao like '%CS%' -- filtra só os CS
	and eq.ativo like 'S'-- filtra as equipes ativas
group by
	1
	
order by 1 asc
;
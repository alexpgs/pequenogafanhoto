select
	cod_atv,
	count(descricao)
from
	empresa ep
	
where
	cod_atv is not null and
	cod_atv = 2
group by 1
order by 2 asc
-- cadastrados como centro de saúde
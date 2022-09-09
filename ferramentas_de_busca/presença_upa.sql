select
*
from 
	atendimento uc
	join usuarios us on uc.cd_usuario = us.cd_usuario
	join empresa ep on uc.empresa = ep.empresa
where 
	us.nm_usuario = 'ALEX PEDRO GONCALVES SEBASTIAO'
	and (ep.descricao = 'UNIDADE DE PRONTO ATENDIMENTO - UPA SUL DA ILHA' or ep.descricao = 'UNIDADE DE PRONTO ATENDIMENTO - UPA NORTE DA ILHA')
	and uc.dt_atendimento::date between '2022-06-01' and '2022-06-21'
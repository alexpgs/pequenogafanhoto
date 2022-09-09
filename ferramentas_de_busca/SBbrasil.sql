select 
uc.cd_usu_cadsus as codigo_usuario,
uc.nm_usuario,
	uc.sg_sexo,
	uc.cpf,
	uc.dt_nascimento,
	uc.nr_telefone,
	uc.nr_telefone_2,
	uc.telefone3,
	uc.telefone4,
	uc.celular,
	euc.nm_logradouro,
	euc.nr_logradouro 
from 
	usuario_cadsus uc 
	join endereco_usuario_cadsus euc on uc.cd_endereco = euc.cd_endereco 
where 
	euc.nm_logradouro like 'MILTON ROQUE RAMOS%' and euc.nr_logradouro = '178'
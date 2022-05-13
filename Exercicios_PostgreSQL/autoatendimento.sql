select
	
	distinct( uc.nm_usuario),
	atd.nr_atendimento,
	pd.ds_procedimento,
	us.ds_login

	
from
	atendimento atd
	join empresa ep on ep.empresa = atd.empresa
	join usuario_cadsus uc on uc.cd_usu_cadsus = atd.cd_usu_cadsus
	join usuarios us on atd.cd_usuario = us.cd_usuario
	join procedimento_competencia pc on atd.cd_procedimento = pc.cd_procedimento
	join procedimento pd on pd.cd_procedimento = pc.cd_procedimento
	
	
where
	 us.cd_usuario = 8977
	 and ep.descricao like 'CS SACO DOS %'
;
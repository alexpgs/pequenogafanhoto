select
p.ds_procedimento,
uc.nm_usuario


from
	procedimento p
	join atendimento_item ai on p.cd_procedimento = ai.cd_procedimento
	join atendimento atd on ai.nr_atendimento = atd.nr_atendimento
	join usuario_cadsus uc on atd.cd_usu_cadsus = uc.cd_usu_cadsus
where	
	
	uc.nm_usuario like 'FERNANDA DOS SANTOS'
    and ds_procedimento like '%HIV%'
    --and ds_procedimento like '%SIF%'
    
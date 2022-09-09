WITH
	denominador_estimado ("quad_texto","denom_estim") as (
		values
			('2022_Q3',110923),
			('2022_Q2',110923),
			('2022_Q1',110923),
			('2021_Q3',110923),
			('2021_Q2',110923),
			('2021_Q1',110923),
			('2020_Q3',109210),
			('2020_Q2',109817),
			('2020_Q1',109185),
			('2019_Q3',109185),
			('2019_Q2',105700),
			('2019_Q1',105546)
	),
	quad as (
		select
			inicio_quad,
			fim_quad,
			max_quad,
			to_char(fim_quad,'YYYY')||
				case
					when to_char(fim_quad, 'MM') = '04' then '_Q1'
					when to_char(fim_quad, 'MM') = '08' then '_Q2'
					when to_char(fim_quad, 'MM') = '12' then '_Q3'
				end as quad_texto
		from (
			select
				coalesce((lag(inicio_quad) over()), fim_quad - interval '4 months')::date as inicio_quad,
				(fim_quad - interval '1 day')::date as fim_quad,
				(fim_quad + interval '8 months' - interval '1 day')::date as max_quad
			FROM (
				SELECT
					generate_series(date_trunc('year', current_date - interval '1 year')::date, current_date + interval '1 year', interval '4 months') as inicio_quad,
					generate_series(date_trunc('year', current_date - interval '1 year')::date, current_date + interval '1 year' + interval '4 months', interval '4 months') as fim_quad
			) t1
		) t2
		where
			inicio_quad >= (current_date - interval '1 year')::date
	),
	unidade_equipe as (
        select
            ea2.cd_area as cd_area,
            e2.cd_equipe_area as cd_equipe_area,
            em2.descricao as unidade,
            eed2.descricao as distrito
        from    
            equipe e2
            left join equipe_area ea2 on ea2.cd_equipe_area = e2.cd_equipe_area
            left join empresa em2 on em2.empresa = e2.empresa
            left join end_estruturado_distrito eed2 on em2.cd_end_estruturado_distrito = eed2.cd_end_estruturado_distrito
		where
            e2.cd_tp_equipe in ('70','76')
    )
		select
			uc.cd_usu_cadsus,
			uc.nm_usuario,
			--uc.dt_nascimento,
			--concat_ws(' | ', uc.celular, uc.nr_telefone, uc.nr_telefone_2) as telefones,
			--uc.cd_endereco,
			--uc.cd_equipe,
			
			icp.cd_procedimento,
			pro.ds_procedimento,
			
			a1.dt_atendimento::date,
			a1.cd_cid_principal,
			a1.cd_cid_secundario,
			ciap2.referencia,
			prob.cd_cid,
			ciap.referencia,
			
			/*last_value(em_atd.descricao) over (
				partition by uc.cd_usu_cadsus
				order by a1.dt_atendimento
				rows between unbounded preceding and unbounded following
			) as ultima_unidade,
			last_value(eqap_atd.cd_area) over (
				partition by uc.cd_usu_cadsus
				order by a1.dt_atendimento 
				rows between unbounded preceding and unbounded following
			) as ultima_equipe,*/
			em_atd.descricao,
			case
				when
					(a1.cd_cid_principal between 'I10' and 'I159'
						or a1.cd_cid_principal in ('I270','I272','O10','O100','O101','O102','O103','O104','O109')
						or ciap2.referencia in ('K86','K87'))
					and em_atd.cod_atv in (1,2)
					then 1
				else 0
			end as conta_previne
		from
			item_conta_paciente icp
			left join atendimento a1 on icp.nr_atendimento = a1.nr_atendimento
			left join usuario_cadsus uc on uc.cd_usu_cadsus = a1.cd_usu_cadsus
			left join grupo_problemas_condicoes prob on uc.cd_usu_cadsus = prob.cd_usu_cadsus
			left join ciap ciap on prob.cd_ciap = ciap.cd_ciap
			left join ciap ciap2 on a1.cd_ciap = ciap2.cd_ciap
            left join empresa em_atd on icp.empresa_faturamento = em_atd.empresa

            left join equipe_profissional e_atd on e_atd.cd_profissional = a1.cd_profissional
                and e_atd.dt_entrada <= a1.dt_atendimento
                and (e_atd.dt_desligamento is null or e_atd.dt_desligamento >= a1.dt_atendimento)
            left join equipe eqp_atd on eqp_atd.cd_equipe = e_atd.cd_equipe 
                and eqp_atd.empresa = icp.empresa_faturamento
                and eqp_atd.cd_tp_equipe in ('70','76')
            left join equipe_area eqap_atd on eqap_atd.cd_equipe_area = eqp_atd.cd_equipe_area
            left join procedimento pro on icp.cd_procedimento = pro.cd_procedimento
		where
			(a1.cd_cid_principal between 'I10' and 'I159'
				or a1.cd_cid_principal in ('I270','I272','O10','O100','O101','O102','O103','O104','O109')
				or a1.cd_cid_secundario between 'I10' and 'I159'
				or a1.cd_cid_secundario in ('I270','I272','O10','O100','O101','O102','O103','O104','O109')
				or ciap2.referencia in ('K86','K87')
				or prob.cd_cid between 'I10' and 'I159'
				or prob.cd_cid in ('I270','I272','O10','O100','O101','O102','O103','O104','O109')
				or ciap.referencia in ('K86','K87'))
			and a1.dt_atendimento >= (current_date - interval '1 year')::date
			and a1.cd_cbo similar to '(225|2231|2235)%'
            and uc.st_excluido = 0
            and uc.st_vivo = 1
            and uc.situacao in (0,1)
			and uc.flag_unificado = 0
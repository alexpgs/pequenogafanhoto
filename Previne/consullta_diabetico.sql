 GISELLE SANTANA 190836
WITH
	denominador_estimado ("quad_texto","denom_estim") as (
		values
			('2022_Q3',27985),
			('2022_Q2',27985),
			('2022_Q1',27985),
			('2021_Q3',27985),
			('2021_Q2',27985),
			('2021_Q1',27985),
			('2020_Q3',27553),
			('2020_Q2',27547),
			('2020_Q1',27547),
			('2019_Q3',27547),
			('2019_Q2',26667),
			('2019_Q1',26629)
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
    ),
	table_lotacao as (
        select distinct
            ep.cd_profissional,
            eqp.empresa,
            ep.dt_entrada,
			e1.descricao as unidade,
            to_date(coalesce(ep.dt_desligamento::text, current_date::text), 'yyyy-mm-dd') as dt_desligamento,
            eqap.cd_area::text as equipe,
			eed2.descricao as distrito
        from
            equipe_profissional ep
            join equipe eqp on eqp.cd_equipe = ep.cd_equipe 
            join empresa e1 on eqp.empresa = e1.empresa
            join equipe_area eqap on eqap.cd_equipe_area = eqp.cd_equipe_area
			left join end_estruturado_distrito eed2 on e1.cd_end_estruturado_distrito = eed2.cd_end_estruturado_distrito
        where
            eqp.cd_tp_equipe in ('70','76')
            and e1.cod_atv = 2
    )
		select
			uc.cd_usu_cadsus,
			uc.nm_usuario,
			uc.dt_nascimento,
			concat_ws(' | ', uc.celular, uc.nr_telefone, uc.nr_telefone_2) as telefones,
			uc.cd_endereco,
			uc.cd_equipe,
			a1.cd_cid_principal,
			a1.cd_cid_secundario,
			prob.cd_cid,
			ciap.referencia,
			a1.dt_atendimento::date as dt_atendimento,
			last_value (tl.unidade) over (
                    partition by uc.cd_usu_cadsus order by tl.dt_entrada
				    rows between unbounded preceding and unbounded following
			) as ultima_unidade,
			last_value (tl.equipe) over (
                    partition by uc.cd_usu_cadsus order by tl.dt_entrada
				    rows between unbounded preceding and unbounded following
			 ) as ultima_equipe,
			case
				when
					(a1.cd_cid_principal like 'E1%'
						or a1.cd_cid_secundario like'E1%'
						or ciap2.referencia similar to '(T89|T90)%')
					and em_atd.cod_atv in (1,2)
					then 1
				else 0
			end as conta_previne
		from
			usuario_cadsus uc
			left join atendimento a1 on uc.cd_usu_cadsus = a1.cd_usu_cadsus
			left join empresa em_atd on em_atd.empresa = a1.empresa
			left join grupo_problemas_condicoes prob on uc.cd_usu_cadsus = prob.cd_usu_cadsus
			left join ciap ciap on prob.cd_ciap = ciap.cd_ciap
			left join ciap ciap2 on a1.cd_ciap = ciap2.cd_ciap
            left join table_lotacao tl on a1.cd_profissional = tl.cd_profissional
				and tl.empresa = a1.empresa
				and a1.dt_atendimento::date >= tl.dt_entrada 
				and a1.dt_atendimento::date <= tl.dt_desligamento
		where	
			(a1.cd_cid_principal similar to '(E10|E11|E12|E13|E14|O240|O241|O242|O243|P702)%'
			or a1.cd_cid_secundario similar to '(E10|E11|E12|E13|E14|O240|O241|O242|O243|P702)%'
			or ciap2.referencia similar to '(T89|T90)%'
			or (prob.cd_cid similar to '(E10|E11|E12|E13|E14||O240|O241|O242|O243|P702)%'
			and prob.situacao <> 99)
			or ciap.referencia similar to '(T89|T90)%')
			and a1.dt_atendimento >= current_date - interval '1 year'
			and a1.cd_cbo similar to '(225|2231|2235)%'
			and uc.st_excluido = 0
            and uc.st_vivo = 1
            and uc.situacao in (0,1)
			and uc.flag_unificado = 0
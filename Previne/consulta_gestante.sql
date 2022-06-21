--- FINALIZADO PARA ANALISE
--- INDICADOR 1 DO PREVINE BRASIL
--- ProporÃ§Ã£o de gestantes com pelo menos 6 consultas prÃ©-natal (PN) realizadas, sendo a primeira realizada atÃ© a 20Âª semana de gestaÃ§Ã£o.

with
	denominador_estimado ("quad_texto","denom_estim") as (
		values
			('2022_Q3',1906),
			('2022_Q2',1906),
			('2022_Q1',1906),
			('2021_Q3',1906),
			('2021_Q2',1906),
			('2021_Q1',1906),
			('2020_Q3',1906),
			('2020_Q2',1906),
			('2020_Q1',1905),
			('2019_Q3',1905),
			('2019_Q2',1845),
			('2019_Q1',1842)
	),
	quad as (
		select
			inicio_quad,
			fim_quad,
			to_char(fim_quad,'YYYY')||
				case
					when to_char(fim_quad, 'MM') = '04' then '_Q1'
					when to_char(fim_quad, 'MM') = '08' then '_Q2'
					when to_char(fim_quad, 'MM') = '12' then '_Q3'
				end as quad_texto
		from (
			select
				coalesce((lag(inicio_quad) over()), fim_quad - interval '4 months')::date as inicio_quad,
				(fim_quad - interval '1 day')::date as fim_quad
			FROM (
				SELECT
					generate_series(date_trunc('year', (current_date - interval '1 month'))::date, (current_date - interval '1 month') + interval '1 year', interval '4 months') as inicio_quad,
					generate_series(date_trunc('year', (current_date - interval '1 month'))::date, (current_date - interval '1 month') + interval '1 year' + interval '4 months', interval '4 months') as fim_quad
			) t1
		) t2
		where
			inicio_quad > ((current_date - interval '1 month') - interval '4 months')::date
	),
	unidade_equipe as (
        select
            ea2.cd_area as cd_area,
            e2.cd_equipe_area as cd_equipe_area,
            em2.descricao as unidade,
            eed2.descricao as distrito,
			e2.dt_ativacao,
			to_date(coalesce(e2.dt_desativacao::text, (current_date - interval '1 month')::text), 'yyyy-mm-dd') as dt_desativacao
        from    
            equipe e2
            left join equipe_area ea2 on ea2.cd_equipe_area = e2.cd_equipe_area
            left join empresa em2 on em2.empresa = e2.empresa
            left join end_estruturado_distrito eed2 on em2.cd_end_estruturado_distrito = eed2.cd_end_estruturado_distrito
		where
            e2.cd_tp_equipe in ('70','76')
			and em2.cod_atv = 2
    ),
	table_lotacao as (
        select distinct
            ep.cd_profissional,
            eqp.empresa,
            ep.dt_entrada,
			e1.descricao as unidade,
            to_date(coalesce(ep.dt_desligamento::text, (current_date - interval '1 month')::text), 'yyyy-mm-dd') as dt_desligamento,
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
		SELECT
			ue1.distrito as distrito_endereco,
			ue1.unidade as unidade_endereco,
			case 
				when ue1.cd_area = 1 then 694::text
				else ue1.cd_area::text end as equipe_endereco,
			ue2.distrito as distrito_lista,
			ue2.unidade as unidade_lista,
			case 
				when ue2.cd_area = 1 then 694::text
				else ue2.cd_area::text end as equipe_lista,
			last_value (tl.distrito) over (
                    partition by uc.cd_usu_cadsus order by tl.dt_entrada
				    rows between unbounded preceding and unbounded following
                ) as distrito_inicio_pn,
			last_value (tl.unidade) over (
                    partition by uc.cd_usu_cadsus order by tl.dt_entrada
				    rows between unbounded preceding and unbounded following
                ) as unidade_inicio_pn,
			last_value (tl.equipe) over (
                    partition by uc.cd_usu_cadsus order by tl.dt_entrada
				    rows between unbounded preceding and unbounded following
                ) as equipe_inicio_pn,
			uc.cd_usu_cadsus,
			pn.dt_ult_menst AS dum,
			(pn.dt_ult_menst + interval '140 day')::date as ate_20_sem,
			to_char(least(pn.dt_fechamento, pn.dt_parto)::date, 'dd-mm-yyyy') as dt_inform_fim_gest,
			least(pn.dt_fechamento, coalesce(pn.dt_parto, (pn.dt_prov_parto::date + interval '14 day')::date, (pn.dt_ult_menst + interval '294 day')::date))::date as dt_encer_gest,
			coalesce((pn.dt_prov_parto::date + interval '14 day')::date, (pn.dt_ult_menst + interval '294 day')::date)::date as dt_final_gest,
			uc.nm_usuario,
			uc.dt_nascimento,
			concat_ws(' | ', uc.celular, uc.nr_telefone, uc.nr_telefone_2) as telefones,
			replace(upper(translate(
                lower(euc.nm_logradouro),
                'Ã¡Ã Ã¢Ã£Ã¤Ã¥ÄÄƒÄ…Ã¨Ã©Ã©ÃªÃ«Ä“Ä•Ä—Ä™Ä›Ã¬Ã­Ã®Ã¯Ã¬Ä©Ä«Ä­á¸©Ã³Ã´ÃµÃ¶ÅÅÅ‘Ã¹ÃºÃ»Ã¼Å©Å«Å­Å¯Ã¤Ã Ã¡Ã¢Ã£Ã¥Ã¦Ã§Ä‡Ä‰ÄÃ¶Ã²Ã³Ã´ÃµÃ¸Ã¼Ã¹ÃºÃ»ÃŸÃ©Ã¨ÃªÃ«Ã½Ã±Ã®Ã¬Ã­Ã¯ÅŸ,;/\',
                'aaaaaaaaaeeeeeeeeeeiiiiiiiihooooooouuuuuuuuaaaaaaeccccoooooouuuuseeeeyniiiis    ')), ',', ' ') as nome_logradouro,
            replace(euc.nr_logradouro, ',', ' ') as numero_logradouro, -- 12
            replace(upper(translate(
                lower(euc.nm_comp_logradouro),
                'Ã¡Ã Ã¢Ã£Ã¤Ã¥ÄÄƒÄ…Ã¨Ã©Ã©ÃªÃ«Ä“Ä•Ä—Ä™Ä›Ã¬Ã­Ã®Ã¯Ã¬Ä©Ä«Ä­á¸©Ã³Ã´ÃµÃ¶ÅÅÅ‘Ã¹ÃºÃ»Ã¼Å©Å«Å­Å¯Ã¤Ã Ã¡Ã¢Ã£Ã¥Ã¦Ã§Ä‡Ä‰ÄÃ¶Ã²Ã³Ã´ÃµÃ¸Ã¼Ã¹ÃºÃ»ÃŸÃ©Ã¨ÃªÃ«Ã½Ã±Ã®Ã¬Ã­Ã¯ÅŸ,;/\',
                'aaaaaaaaaeeeeeeeeeeiiiiiiiihooooooouuuuuuuuaaaaaaeccccoooooouuuuseeeeyniiiis    ')), ',', ' ') as complemento_logradouro
		FROM
			prenatal pn
			join usuario_cadsus uc ON pn.cd_usu_cadsus = uc.cd_usu_cadsus
			left join endereco_usuario_cadsus euc on euc.cd_endereco = uc.cd_endereco
				and euc.st_ativo = 1
			left join tipo_logradouro_cadsus tlc on tlc.cd_tipo_logradouro = euc.cd_tipo_logradouro
			left join cidade c on c.cod_cid = euc.cod_cid
			--left join usuario_cadsus_cns ucc on ucc.cd_usu_cadsus = uc.cd_usu_cadsus
			-- endereco estruturado
			left join endereco_estruturado ee on ee.cd_endereco_estruturado = euc.cd_endereco_estruturado
			left join equipe_micro_area ema on ema.cd_eqp_micro_area = ee.cd_eqp_micro_area
			-- equipe territÃ³rio
            left join unidade_equipe ue1 on ue1.cd_equipe_area = ema.cd_equipe_area
            
		-- equipe lista
 		left join equipe eq on uc.cd_equipe = eq.cd_equipe
           	left join equipe_area eqa on eqa.cd_equipe_area = eq.cd_equipe_area
           	left join unidade_equipe ue2 on eqa.cd_area = ue2.cd_area            


			-- equipe inicio pre-natal
			left join usuarios usu on pn.cd_usuario = usu.cd_usuario
			left join table_lotacao tl on usu.cd_profissional = tl.cd_profissional
				and pn.dt_cadastro::date >= tl.dt_entrada 
				and pn.dt_cadastro::date <= tl.dt_desligamento
		WHERE
			(pn.desfecho not in (1,2,3,4,5,6,7,8,9,10)
			or pn.desfecho is null)
			and uc.flag_unificado = 0
			and uc.st_vivo = 1
			and uc.situacao in (0,1)
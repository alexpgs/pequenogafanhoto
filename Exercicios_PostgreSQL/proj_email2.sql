select
	distinct(uc.nm_usuario),
	uc.dt_nascimento,
	rti.nm_produto
	
	
from
	usuario_cadsus uc
	join atendimento atd on uc.cd_usu_cadsus = atd.cd_usu_cadsus
	join receituario rt on rt.cd_usuario = atd.cd_usuario
	join receituario_item rti on rti.cd_receituario = rt.cd_receituario
	
where
	rti.nm_produto like 'ANLODIPINO, BESILATO 5 MG' or rti.nm_produto like 'ANLODIPINO, BESILATO 10 MG' or rti.nm_produto like 'AMIODARONA 200 MG'
	or rti.nm_produto like 'ATENOLOL 50 MG' or rti.nm_produto like 'CARVEDILOL 25MG' or rti.nm_produto like 'CARVEDILOL 6,25 MG' 
	or rti.nm_produto like 'CAPTOPRIL 12,5 MG' or rti.nm_produto like 'DIGOXINA 0,25 MG' or rti.nm_produto like '' 
	or rti.nm_produto like 'ENALAPRIL, MALEATO 5MG' or rti.nm_produto like 'ENALAPRIL, MALEATO 20 MG' or rti.nm_produto like 'ENALAPRIL, MALEATO  10 MG' 
	or rti.nm_produto like 'ESPIRONOLACTONA 25 MG' or rti.nm_produto like 'FUROSEMIDA 40 MG' or rti.nm_produto like 'HIDROCLOROTIAZIDA 25 MG'
	or rti.nm_produto like 'ISOSSORBIDA, DINITRATO 5 MG SUBLINGUAL' or rti.nm_produto like 'ISOSSORBIDA, MONONITRATO 20 MG'
	or rti.nm_produto like 'LOSARTANA POTÁSSICA 50 MG' or rti.nm_produto like 'METILDOPA 250 MG' or rti.nm_produto like 'PROPRANOLOL, CLORIDRATO 40 MG' 
	or rti.nm_produto like 'SINVASTATINA 40 MG' or rti.nm_produto like 'SINVASTATINA 20 MG' or rti.nm_produto like 'VERAPAMIL, CLORIDRATO 80 MG' 
	or rti.nm_produto like 'GLIBENCLAMIDA 5 MG' or rti.nm_produto like 'INSULINA HUMANA NPH 100 UI/ML- CANETA' or rti.nm_produto like 'INSULINA HUMANA REGULAR 100 UI/ML – CANETA' 
	or rti.nm_produto like 'INSULINA NPH  U100' or rti.nm_produto like 'INSULINA REGULAR  U100' or rti.nm_produto like 'INSULINA REGULAR HUMANA 100 UI/ML'
	or rti.nm_produto like 'INSULINA NPH HUMANA 100 UI/ML' or rti.nm_produto like 'METFORMINA, CLORIDRATO 850 MG' or rti.nm_produto like 'ACIDO ACETIL SALICILICO 100 MG'
	or rti.nm_produto like 'CLOPIDOGREL 75 MG' or rti.nm_produto like 'AGULHA PARA CANETA DE INSULINA' or rti.nm_produto like 'AGULHA BD P/ CANETA DE INSULINA 4 MM'
	or rti.nm_produto like '' or rti.nm_produto like 'AGULHA BD P/ CANETA DE INSULINA 5 MM' or rti.nm_produto like 'AGULHA BD P/ CANETA DE INSULINA 8 MM' 
	
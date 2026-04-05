class_name Mazo extends Resource
var iMinCards = 10
var aCards = []
var aCardsDescarte = []
var aCardsOriginal = []
var aCardsDictionary = {
	"granadero":0,
	"correntino":0,
	"arribeno":0,
	"moreno":0,
	"cebador":0,
	"mignon":0,
	"pardo":0,
	"upgrade_life":0,
	"ollas_del_pueblo":0,
	"barrilete_cosmico":0,
	"ataque_husares_infernales":0,
	"manuela_pedraza":0,
	"sudestada":0,
	"tedeum":0,
	"defensa_de_obligado":0,
	"patricio_solari":0,
}

static func crear(aOriginalCards = []):
	var oMazo = Mazo.new()
	if aOriginalCards.size() > 0:
		oMazo.generar_mazo(aOriginalCards)
	elif oMazo.aCards.size() == 0:
		oMazo.rellenar_mazo_test()
	oMazo.aCardsOriginal = str_to_var(var_to_str(oMazo.aCards))
	return oMazo

func generar_mazo(aOriginalCards):
	for oCard in aOriginalCards:
		crear_cartas(oCard.name, oCard.quantity)
	
func crear_cartas(sDecisionMessage, iCantidad):
	for i in range(iCantidad):
		var oCard = crear_carta(sDecisionMessage)
		aCards.push_back(oCard)
		aCardsDictionary[sDecisionMessage] += 1
		
func crear_carta(sDecisionMessage):
	var oCard = null
	if sDecisionMessage == "granadero":
		oCard = {"tipo": "unidad", "titulo": "_PATRICIO_", "numero": "1", "decision_time_message": "granadero", "cantidad": 1, "posicion_en_mano": 0, "leyenda": "_PATRICIO_LEYENDA_"}
	elif sDecisionMessage == "correntino":
		oCard = {"tipo": "unidad", "titulo": "_CORRENTINO_", "numero": "2", "decision_time_message": "correntino", "cantidad": 1, "posicion_en_mano": 0, "leyenda": "_CORRENTINO_LEYENDA_"}
	elif sDecisionMessage == "arribeno":
		oCard = {"tipo": "unidad", "titulo": "_ARRIBENO_", "numero": "3", "decision_time_message": "arribeno", "cantidad": 1, "posicion_en_mano": 0, "leyenda": "_ARRIBENO_LEYENDA_"}
	elif sDecisionMessage == "moreno":
		oCard = {"tipo": "unidad", "titulo": "_MORENO_", "numero": "4", "decision_time_message": "moreno", "cantidad": 1, "posicion_en_mano": 0, "leyenda": "_MORENO_LEYENDA_"}	
	elif sDecisionMessage == "cebador":
		oCard = {"tipo": "unidad", "titulo": "_CEBADOR_", "numero": "5", "decision_time_message": "cebador", "cantidad": 1, "posicion_en_mano": 0, "leyenda": "_CEBADOR_LEYENDA_"}	
	elif sDecisionMessage == "mignon":
		oCard = {"tipo": "unidad", "titulo": "_MIGNON_", "numero": "6", "decision_time_message": "mignon", "cantidad": 1, "posicion_en_mano": 0, "leyenda": "_MIGNON_LEYENDA_"}	
	elif sDecisionMessage == "pardo":
		oCard = {"tipo": "unidad", "titulo": "_PARDO_", "numero": "7", "decision_time_message": "pardo", "cantidad": 1, "posicion_en_mano": 0, "leyenda": "_PARDO_LEYENDA_"}			
	elif sDecisionMessage == "upgrade_life":
		oCard = {"tipo": "truco", "titulo": "_MATE_", "numero": "1", "decision_time_message": "upgrade_life", "cantidad": 1, "posicion_en_mano": 0, "leyenda": "_MATE_LEYENDA_"}
	elif sDecisionMessage == "ollas_del_pueblo":
		oCard = {"tipo": "truco", "titulo": "_PUEBLO_EN_ARMAS_", "numero": "2", "decision_time_message": "ollas_del_pueblo", "cantidad": 1, "posicion_en_mano": 0, "leyenda": "_PUEBLO_EN_ARMAS_LEYENDA_"}
	elif sDecisionMessage == "barrilete_cosmico":
		oCard = {"tipo": "evento", "titulo": "_BARRILETE_COSMICO_", "numero": "1", "decision_time_message": "barrilete_cosmico", "cantidad": 1, "posicion_en_mano": 0, "leyenda": "_BARRILETE_COSMICO_LEYENDA_"}
	elif sDecisionMessage == "ataque_husares_infernales":
		oCard = {"tipo": "evento", "titulo": "_HUSARES_INFERNALES_", "numero": "2", "decision_time_message": "ataque_husares_infernales", "cantidad": 1, "posicion_en_mano": 0, "leyenda": "_HUSARES_INFERNALES_LEYENDA_"}
	elif sDecisionMessage == "manuela_pedraza":
		oCard = {"tipo": "evento", "titulo": "_MANUELA_", "numero": "3", "decision_time_message": "manuela_pedraza", "cantidad": 1, "posicion_en_mano": 0, "leyenda": "_MANUELA_LEYENDA_"}
	elif sDecisionMessage == "sudestada":
		oCard = {"tipo": "evento", "titulo": "_SUDESTADA_", "numero": "4", "decision_time_message": "sudestada", "cantidad": 1, "posicion_en_mano": 0, "leyenda": "_SUDESTADA_LEYENDA_"}
	elif sDecisionMessage == "tedeum":
		oCard = {"tipo": "evento", "titulo": "_TEDEUM_", "numero": "5", "decision_time_message": "tedeum", "cantidad": 1, "posicion_en_mano": 0, "leyenda": "_TEDEUM_LEYENDA_"}
	elif sDecisionMessage == "defensa_de_obligado":
		oCard = {"tipo": "evento", "titulo": "_DEFENDA_DE_OBLIGADO_", "numero": "6", "decision_time_message": "defensa_de_obligado", "cantidad": 1, "posicion_en_mano": 0, "leyenda": "_DEFENDA_DE_OBLIGADO_LEYENDA_"}
	elif sDecisionMessage == "patricio_solari":
		oCard = {"tipo": "evento", "titulo": "_PATRICIO_SOLARI_", "numero": "7", "decision_time_message": "patricio_solari", "cantidad": 1, "posicion_en_mano": 0, "leyenda": "_PATRICIO_SOLARI_LEYENDA_"}
	return oCard

func size():
	return aCards.size()

func rearmar():
	aCards = str_to_var(var_to_str(aCardsOriginal))
	
func mezclar():
	aCards.shuffle()

func tomar_carta():
	var oCard = null
	if aCards.size() == 0:
		aCardsDescarte.shuffle()
		aCards = aCardsDescarte
		
	if aCards.size() > 0:
		oCard = aCards.pop_front()
		var oNewCard = str_to_var(var_to_str(oCard))
		aCardsDescarte.push_back(oNewCard)
	return oCard

func quitar_carta(sDecisionMessage):
	if aCardsDictionary[sDecisionMessage] > 0:
		for oCard in aCards:
			var oSelectedCard = aCards.pop_front()
			if not oSelectedCard.decision_time_message == sDecisionMessage:
				aCards.push_back(oSelectedCard)
			else:
				break
		aCardsDictionary[sDecisionMessage] -= 1
	
func cantidad_cartas(sDecisionMessage):
	return aCardsDictionary[sDecisionMessage]

func get_diccionario_de_cartas():
	return aCardsDictionary
	
	
	
# Funciones de testing
func rellenar_mazo_test():
	if Global.settings.demo:
		crear_cartas("granadero", 4)
		crear_cartas("correntino", 2)
		crear_cartas("arribeno", 2)
		crear_cartas("moreno", 1)
		crear_cartas("ataque_husares_infernales", 1)
		crear_cartas("upgrade_life", 3)
		crear_cartas("ollas_del_pueblo", 1)
		crear_cartas("patricio_solari", 1)
	else:
		crear_cartas("granadero", 4)
		crear_cartas("correntino", 2)
		crear_cartas("arribeno", 2)
		crear_cartas("moreno", 2)
		crear_cartas("cebador", 1)
		crear_cartas("mignon", 2)
		crear_cartas("pardo", 2)
		crear_cartas("upgrade_life", 3)
		crear_cartas("ollas_del_pueblo", 2)
		crear_cartas("barrilete_cosmico", 1)
		crear_cartas("ataque_husares_infernales", 1)
		crear_cartas("manuela_pedraza", 1)
		crear_cartas("sudestada", 1)
		crear_cartas("tedeum", 1)
		crear_cartas("defensa_de_obligado", 1)
		crear_cartas("patricio_solari", 1)

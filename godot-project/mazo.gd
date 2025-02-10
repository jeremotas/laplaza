class_name Mazo extends Resource
var iMinCards = 10
var aCards = []

static func crear(aOriginalCards = []):
	var oMazo = Mazo.new()
	
	oMazo.aCards = aOriginalCards
	if oMazo.aCards.size() == 0:
		oMazo.rellenar_mazo_test()
		
	oMazo.mezclar()
	
	return oMazo

func rellenar_mazo_test():
	crear_cartas("granadero", 10)
	crear_cartas("correntino", 1)
	crear_cartas("arribeno", 3)
	crear_cartas("moreno", 1)
	crear_cartas("upgrade_life", 10)
	crear_cartas("ollas_del_pueblo", 4)
	crear_cartas("barrilete_cosmico", 1)
	crear_cartas("ataque_husares_infernales", 10)
	
func crear_cartas(sDecisionMessage, iCantidad):
	for i in range(iCantidad):
		var oCard = crear_carta(sDecisionMessage)
		aCards.push_back(oCard)
		
func crear_carta(sDecisionMessage):
	var oCard = null
	if sDecisionMessage == "granadero":
		oCard = {"tipo": "unidad", "titulo": "Patricio", "decision_time_message": "granadero", "cantidad": 1, "posicion_en_mano": 0, "leyenda": "El bien ponderado patricio que ataca con precisión al enemigo. __ Tarda en recargar, sino seria un escándalo."}
	elif sDecisionMessage == "correntino":
		oCard = {"tipo": "unidad", "titulo": "Correntino", "decision_time_message": "correntino", "cantidad": 1, "posicion_en_mano": 0, "leyenda": "Tira de lejos cual cazador de ñandú. __ Camina lento, pero si pega... pega. __ Eso si, le pegan una y adiós."}
	elif sDecisionMessage == "arribeno":
		oCard = {"tipo": "unidad", "titulo": "Correntino", "decision_time_message": "correntino", "cantidad": 1, "posicion_en_mano": 0, "leyenda": "¿Tenés escopeta? __ Tengo escopeta. __ Agarrate fuerte que los de Arriba van con perdigones de plomo."}
	elif sDecisionMessage == "moreno":
		oCard = {"tipo": "unidad", "titulo": "Correntino", "decision_time_message": "correntino", "cantidad": 1, "posicion_en_mano": 0, "leyenda": "Fiel y aguantador como pocos. __ Lanza granadas hacia donde diga el general. __ Era eso o quedar como esclavo."}	
	elif sDecisionMessage == "upgrade_life":
		oCard = {"tipo": "truco", "titulo": "Matecito", "decision_time_message": "upgrade_life", "cantidad": 1, "posicion_en_mano": 0, "leyenda": "El general se toma unos verdes y recupera la vida. __ Eso si, me dijeron que lo toma amargo."}
	elif sDecisionMessage == "ollas_del_pueblo":
		oCard = {"tipo": "truco", "titulo": "El pueblo en armas", "decision_time_message": "ollas_del_pueblo", "cantidad": 1, "posicion_en_mano": 0, "leyenda": "Y un buen dia las cacerolas del pueblo entraron en vigor sobre Buenos Aires... __ (¿Dónde lo vi?)"}
	elif sDecisionMessage == "barrilete_cosmico":
		oCard = {"tipo": "evento", "titulo": "Barrilete cosmico", "decision_time_message": "barrilete_cosmico", "cantidad": 1, "posicion_en_mano": 0, "leyenda": "El general es poseído temporalmente por Pelusa. __ Si hay ingleses, él los gambetea y ellos caen al piso. __ (La enfedrina queda en la sangre del general)"}
	elif sDecisionMessage == "ataque_husares_infernales":
		oCard = {"tipo": "evento", "titulo": "Husares infernales", "decision_time_message": "ataque_husares_infernales", "cantidad": 1, "posicion_en_mano": 0, "leyenda": "Estos jinetes desataran un infierno de balas sobre los ingleses. __ (¡Ojo! Pasan una vez y chau pinola)"}
	
	return oCard

func size():
	return aCards.size()
	
func mezclar():
	aCards.shuffle()

func tomar_carta():
	var oCard = null
	if aCards.size() > 0:
		oCard = aCards.pop_front()
	return oCard

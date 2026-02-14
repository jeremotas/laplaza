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
		oCard = {"tipo": "unidad", "titulo": "Patricio", "numero": "1", "decision_time_message": "granadero", "cantidad": 1, "posicion_en_mano": 0, "leyenda": "El bien ponderado patricio que ataca con precisión al enemigo. __ Tarda en recargar, sino seria un escándalo."}
	elif sDecisionMessage == "correntino":
		oCard = {"tipo": "unidad", "titulo": "Correntino", "numero": "2", "decision_time_message": "correntino", "cantidad": 1, "posicion_en_mano": 0, "leyenda": "Tira de lejos cual cazador de ñandú. __ Camina lento, pero si pega... pega. __ Eso si, le pegan una y adiós."}
	elif sDecisionMessage == "arribeno":
		oCard = {"tipo": "unidad", "titulo": "Arribeño", "numero": "3", "decision_time_message": "arribeno", "cantidad": 1, "posicion_en_mano": 0, "leyenda": "¿Tenés escopeta? __ Tengo escopeta. __ Agarrate fuerte que los de Arriba van con perdigones de plomo."}
	elif sDecisionMessage == "moreno":
		oCard = {"tipo": "unidad", "titulo": "Moreno", "numero": "4", "decision_time_message": "moreno", "cantidad": 1, "posicion_en_mano": 0, "leyenda": "Fiel y aguantador como pocos. __ Lanza granadas hacia donde diga el general. __ Era eso o quedar como esclavo."}	
	elif sDecisionMessage == "cebador":
		oCard = {"tipo": "unidad", "titulo": "Cebador", "numero": "5", "decision_time_message": "cebador", "cantidad": 1, "posicion_en_mano": 0, "leyenda": "No es el aguatero, es el cebador de mates. __ Te mantiene con vida en esos momentos. __ Amargo, el mate. Bueno, el tambien."}	
	elif sDecisionMessage == "mignon":
		oCard = {"tipo": "unidad", "titulo": "Miñon", "numero": "6", "decision_time_message": "mignon", "cantidad": 1, "posicion_en_mano": 0, "leyenda": "No es la palomita de Ginobili, pero... __ Con este doblete les pasamos factura!"}	
	elif sDecisionMessage == "pardo":
		oCard = {"tipo": "unidad", "titulo": "Pardo", "numero": "7", "decision_time_message": "pardo", "cantidad": 1, "posicion_en_mano": 0, "leyenda": "Al ritmo del tambor, del tamboril! __ Una dosis de adrenalina permanente a los huesos."}			
	elif sDecisionMessage == "upgrade_life":
		oCard = {"tipo": "truco", "titulo": "Matecito", "numero": "1", "decision_time_message": "upgrade_life", "cantidad": 1, "posicion_en_mano": 0, "leyenda": "El general se toma unos verdes y recupera la vida. __ Eso si, me dijeron que lo toma amargo."}
	elif sDecisionMessage == "ollas_del_pueblo":
		oCard = {"tipo": "truco", "titulo": "El pueblo en armas", "numero": "2", "decision_time_message": "ollas_del_pueblo", "cantidad": 1, "posicion_en_mano": 0, "leyenda": "Y un buen dia las cacerolas del pueblo entraron en vigor sobre Buenos Aires... __ (¿Dónde lo vi?)"}
	elif sDecisionMessage == "barrilete_cosmico":
		oCard = {"tipo": "evento", "titulo": "Barrilete cosmico", "numero": "1", "decision_time_message": "barrilete_cosmico", "cantidad": 1, "posicion_en_mano": 0, "leyenda": "El general es poseído temporalmente por Pelusa. __ Si hay ingleses, él los gambetea y ellos caen al piso. __ (La enfedrina queda en la sangre del general)"}
	elif sDecisionMessage == "ataque_husares_infernales":
		oCard = {"tipo": "evento", "titulo": "Husares infernales", "numero": "2", "decision_time_message": "ataque_husares_infernales", "cantidad": 1, "posicion_en_mano": 0, "leyenda": "Estos jinetes desataran un infierno de balas sobre los ingleses. __ (¡Ojo! Pasan una vez y chau pinola)"}
	elif sDecisionMessage == "manuela_pedraza":
		oCard = {"tipo": "evento", "titulo": "Manuela", "numero": "3", "decision_time_message": "manuela_pedraza", "cantidad": 1, "posicion_en_mano": 0, "leyenda": "A sablazos moriran los ingleses __ Lo que pueden las mujeres despechadas!"}
	elif sDecisionMessage == "sudestada":
		oCard = {"tipo": "evento", "titulo": "Sudestada", "numero": "4", "decision_time_message": "sudestada", "cantidad": 1, "posicion_en_mano": 0, "leyenda": "El viento trae una copla __ Lentitos los ingleses en el barro..."}
	elif sDecisionMessage == "tedeum":
		oCard = {"tipo": "evento", "titulo": "Tedeum catedral", "numero": "5", "decision_time_message": "tedeum", "cantidad": 1, "posicion_en_mano": 0, "leyenda": "Vamos a decir que la iglesia nos dio una mano... __ Ah no! Eso era pelusa."}
	elif sDecisionMessage == "defensa_de_obligado":
		oCard = {"tipo": "evento", "titulo": "Defensa de obligado", "numero": "6", "decision_time_message": "defensa_de_obligado", "cantidad": 1, "posicion_en_mano": 0, "leyenda": "Sin cadenas sobre los pies... __ Pero si protegiendo la plaza!"}
	elif sDecisionMessage == "patricio_solari":
		oCard = {"tipo": "evento", "titulo": "Patricio Solari", "numero": "7", "decision_time_message": "patricio_solari", "cantidad": 1, "posicion_en_mano": 0, "leyenda": "Se viene el pogo mas grande del mundo! __ Y los ingleses no van a entender que les paso."}
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

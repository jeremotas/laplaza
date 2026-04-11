extends Node;
var iMaxTime = 600
var iMaxStarters = 30
var iMaxFirstWave = 180
var iMaxSecondWave = 360
var iMaxThirdWave = 540


# Posibles unidades
# ingles
# green_soldier
# highlander
# english_cavalry
# royal_marine
# zapador
# abanderado (pendiente)
# cannon


var aStarters = [	
	{
		"duration": 6,
		"max_alive": 10,
		"name": "_EL_ASALTO_ESCARLATA_",
		"add_descanso": false,
		"arriba_izquierda": {"unit_type": "ingles", "seconds": 1, "probability": 0},
		"arriba_centro": {"unit_type": "ingles", "seconds": 1, "probability":100},
		"arriba_derecha": {"unit_type": "ingles", "seconds": 1, "probability": 0},
		"izquierda_superior": {"unit_type": "ingles", "seconds": 2, "probability": 80},
		"izquierda_inferior": {"unit_type": "ingles", "seconds": 1, "probability": 0},
		"derecha_superior": {"unit_type": "ingles", "seconds": 2, "probability": 80},
		"derecha_inferior": {"unit_type": "ingles", "seconds": 1, "probability": 0},
	},
	{
		"duration": 6,
		"max_alive": 4,
		"name": "La Marcha de los Inmortales",
		"add_descanso": false,
		"arriba_izquierda": {"unit_type": "highlander", "seconds": 1, "probability": 60},
		"arriba_centro": {"unit_type": "highlander", "seconds": 1, "probability":100},
		"arriba_derecha": {"unit_type": "highlander", "seconds": 1, "probability": 60},
		"izquierda_superior": {"unit_type": "ingles", "seconds": 2, "probability": 40},
		"izquierda_inferior": {"unit_type": "ingles", "seconds": 3, "probability": 50},
		"derecha_superior": {"unit_type": "ingles", "seconds": 2, "probability": 40},
		"derecha_inferior": {"unit_type": "ingles", "seconds": 3, "probability": 50},
	},
	
	{
		"duration": 6,
		"max_alive": 15,
		"name": "Viento Oeste",
		"add_descanso": false,
		"arriba_izquierda": {"unit_type": "green_soldier", "seconds": 5, "probability": 50},
		"arriba_centro": {"unit_type": "ingles", "seconds": 5, "probability":50},
		"arriba_derecha": {"unit_type": "ingles", "seconds": 5, "probability": 20},
		"izquierda_superior": {"unit_type": "green_soldier", "seconds": 5, "probability": 50},
		"izquierda_inferior": {"unit_type": "green_soldier", "seconds": 5, "probability": 0},
		"derecha_superior": {"unit_type": "ingles", "seconds": 5, "probability": 15},
		"derecha_inferior": {"unit_type": "ingles", "seconds": 5, "probability": 10},
	},
	{
		"duration": 5,
		"max_alive": 15,
		"name": "Viento Este",
		"add_descanso": false,
		"arriba_izquierda": {"unit_type": "ingles", "seconds": 3, "probability": 20},
		"arriba_centro": {"unit_type": "ingles", "seconds": 5, "probability":50},
		"arriba_derecha": {"unit_type": "green_soldier", "seconds": 5, "probability": 50},
		"izquierda_superior": {"unit_type": "ingles", "seconds": 5, "probability": 15},
		"izquierda_inferior": {"unit_type": "ingles", "seconds": 3, "probability": 10},
		"derecha_superior": {"unit_type": "green_soldier", "seconds": 5, "probability": 50},
		"derecha_inferior": {"unit_type": "green_soldier", "seconds": 5, "probability": 0},
	},
]
var aFirstWaves = [
	{
		"duration": 10,
		"max_alive": 15,
		"name": "Alta probabilidad de lluvias",
		"add_descanso": false,
		"arriba_izquierda": {"unit_type": "ingles", "seconds": 1, "probability": 50},
		"arriba_centro": {"unit_type": "ingles", "seconds": 1, "probability":100},
		"arriba_derecha": {"unit_type": "ingles", "seconds": 1, "probability": 50},
		"izquierda_superior": {"unit_type": "ingles", "seconds": 2, "probability": 80},
		"izquierda_inferior": {"unit_type": "ingles", "seconds": 1, "probability": 0},
		"derecha_superior": {"unit_type": "ingles", "seconds": 2, "probability": 80},
		"derecha_inferior": {"unit_type": "ingles", "seconds": 1, "probability": 0},
	},
	{
		"duration": 6,
		"max_alive": 20,
		"name": "Los Inmortales Contraatacan",
		"add_descanso": false,
		"arriba_izquierda": {"unit_type": "highlander", "seconds": 1, "probability": 75},
		"arriba_centro": {"unit_type": "highlander", "seconds": 1, "probability":100},
		"arriba_derecha": {"unit_type": "highlander", "seconds": 1, "probability": 75},
		"izquierda_superior": {"unit_type": "ingles", "seconds": 2, "probability": 60},
		"izquierda_inferior": {"unit_type": "ingles", "seconds": 3, "probability": 50},
		"derecha_superior": {"unit_type": "ingles", "seconds": 2, "probability": 60},
		"derecha_inferior": {"unit_type": "ingles", "seconds": 3, "probability": 50},
	},
	{
		"duration": 6,
		"max_alive": 20,
		"name": "Bandera de Pirata",
		"add_descanso": false,
		"arriba_izquierda": {"unit_type": "highlander", "seconds": 1, "probability": 60},
		"arriba_centro": {"unit_type": "flagger", "seconds": 6, "probability":100, "guards": {"unit_type":"green_soldier", "quantity": 4}},
		"arriba_derecha": {"unit_type": "highlander", "seconds": 1, "probability": 60},
		"izquierda_superior": {"unit_type": "ingles", "seconds": 2, "probability": 40},
		"izquierda_inferior": {"unit_type": "ingles", "seconds": 3, "probability": 50},
		"derecha_superior": {"unit_type": "ingles", "seconds": 2, "probability": 40},
		"derecha_inferior": {"unit_type": "ingles", "seconds": 3, "probability": 50},
	},
	{
		"duration": 6,
		"max_alive": 20,
		"name": "Paso Doble",
		"add_descanso": false,
		"arriba_izquierda": {"unit_type": "green_soldier", "seconds": 2, "probability": 50},
		"arriba_centro": {"unit_type": "green_soldier", "seconds": 2, "probability":50},
		"arriba_derecha": {"unit_type": "green_soldier", "seconds": 3, "probability": 20},
		"izquierda_superior": {"unit_type": "green_soldier", "seconds": 2, "probability": 50},
		"izquierda_inferior": {"unit_type": "green_soldier", "seconds": 2, "probability": 0},
		"derecha_superior": {"unit_type": "green_soldier", "seconds": 2, "probability": 15},
		"derecha_inferior": {"unit_type": "green_soldier", "seconds": 3, "probability": 10},
	},
	{
		"duration": 6,
		"max_alive": 20,
		"name": "Paso Doble",
		"add_descanso": false,
		"arriba_izquierda": {"unit_type": "green_soldier", "seconds": 3, "probability": 20},
		"arriba_centro": {"unit_type": "green_soldier", "seconds": 2, "probability":50},
		"arriba_derecha": {"unit_type": "green_soldier", "seconds": 2, "probability": 50},
		"izquierda_superior": {"unit_type": "green_soldier", "seconds": 2, "probability": 15},
		"izquierda_inferior": {"unit_type": "green_soldier", "seconds": 3, "probability": 10},
		"derecha_superior": {"unit_type": "green_soldier", "seconds": 2, "probability": 50},
		"derecha_inferior": {"unit_type": "green_soldier", "seconds": 2, "probability": 0},
	},
]
var aSecondWaves = [
	{
		"duration": 6,
		"max_alive": 25,
		"name": "El Imperio Pirata",
		"add_descanso": false,
		"arriba_izquierda": {"unit_type": "highlander", "seconds": 3, "probability": 75},
		"arriba_centro": {"unit_type": "royal_marine", "seconds": 6, "probability":100},
		"arriba_derecha": {"unit_type": "highlander", "seconds": 3, "probability": 75},
		"izquierda_superior": {"unit_type": "green_soldier", "seconds": 2, "probability": 75},
		"izquierda_inferior": {"unit_type": "ingles", "seconds": 1, "probability": 0},
		"derecha_superior": {"unit_type": "green_soldier", "seconds": 2, "probability": 75},
		"derecha_inferior": {"unit_type": "ingles", "seconds": 1, "probability": 0},
	},
	{
		"duration": 6,
		"max_alive": 25,
		"name": "Ataque Carmesí",
		"add_descanso": false,
		"arriba_izquierda": {"unit_type": "royal_marine", "seconds": 4, "probability": 75},
		"arriba_centro": {"unit_type": "highlander", "seconds": 2, "probability":100},
		"arriba_derecha": {"unit_type": "royal_marine", "seconds": 4, "probability": 75},
		"izquierda_superior": {"unit_type": "green_soldier", "seconds": 2, "probability": 75},
		"izquierda_inferior": {"unit_type": "ingles", "seconds": 1, "probability": 0},
		"derecha_superior": {"unit_type": "green_soldier", "seconds": 2, "probability": 75},
		"derecha_inferior": {"unit_type": "ingles", "seconds": 1, "probability": 0},
	},
	{
		"duration": 6,
		"max_alive": 25,
		"name": "Avance de la Caballería",
		"add_descanso": false,
		"arriba_izquierda": {"unit_type": "green_soldier", "seconds": 3, "probability": 75},
		"arriba_centro": {"unit_type": "english_cavalry", "seconds": 4, "probability":100},
		"arriba_derecha": {"unit_type": "green_soldier", "seconds": 3, "probability": 75},
		"izquierda_superior": {"unit_type": "highlander", "seconds": 3, "probability": 75},
		"izquierda_inferior": {"unit_type": "ingles", "seconds": 1, "probability": 0},
		"derecha_superior": {"unit_type": "highlander", "seconds": 3, "probability": 75},
		"derecha_inferior": {"unit_type": "ingles", "seconds": 1, "probability": 0},
	},
	{
		"duration": 6,
		"max_alive": 30,
		"name": "La banderola",
		"add_descanso": false,
		"izquierda_inferior": {"unit_type": "ingles", "seconds": 1, "probability": 0},
		"izquierda_superior": {"unit_type": "highlander", "seconds": 3, "probability": 30},
		"arriba_izquierda": {"unit_type": "ingles", "seconds": 2, "probability": 0},
		"arriba_centro": {"unit_type": "flagger", "seconds": 6, "probability":100, "guards": {"unit_type":"green_soldier", "quantity": 4}},
		"arriba_derecha": {"unit_type": "ingles", "seconds": 2, "probability": 0},
		"derecha_superior": {"unit_type": "highlander", "seconds": 3, "probability": 30},
		"derecha_inferior": {"unit_type": "ingles", "seconds": 1, "probability": 0},
	},
]
var aThirdWaves = [
	{
		"duration": 6,
		"max_alive": 30,
		"name": "Ataque de la Caballería",
		"add_descanso": false,
		"arriba_izquierda": {"unit_type": "green_soldier", "seconds": 2, "probability": 75},
		"arriba_centro": {"unit_type": "english_cavalry", "seconds": 3, "probability":100},
		"arriba_derecha": {"unit_type": "green_soldier", "seconds": 2, "probability": 75},
		"izquierda_superior": {"unit_type": "ingles", "seconds": 3, "probability": 75},
		"izquierda_inferior": {"unit_type": "ingles", "seconds": 1, "probability": 0},
		"derecha_superior": {"unit_type": "ingles", "seconds": 3, "probability": 75},
		"derecha_inferior": {"unit_type": "ingles", "seconds": 1, "probability": 0},
	},
	{
		"duration": 6,
		"max_alive": 30,
		"name": "Muchos Marines de los mandarines",
		"add_descanso": false,
		"arriba_izquierda": {"unit_type": "royal_marine", "seconds": 2, "probability": 75},
		"arriba_centro": {"unit_type": "royal_marine", "seconds": 3, "probability":100},
		"arriba_derecha": {"unit_type": "royal_marine", "seconds": 2, "probability": 75},
		"izquierda_superior": {"unit_type": "green_soldier", "seconds": 3, "probability": 75},
		"izquierda_inferior": {"unit_type": "ingles", "seconds": 1, "probability": 0},
		"derecha_superior": {"unit_type": "green_soldier", "seconds": 3, "probability": 75},
		"derecha_inferior": {"unit_type": "ingles", "seconds": 1, "probability": 0},
	},
]

var aFinale = [
	{
		"duration": 6,
		"max_alive": 30,
		"name": "Ataque Final",
		"add_descanso": false,
		"arriba_izquierda": {"unit_type": "english_cavalry", "seconds": 2, "probability": 75},
		"arriba_centro": {"unit_type": "zapador", "seconds": 2, "probability":100},
		"arriba_derecha": {"unit_type": "english_cavalry", "seconds": 2, "probability": 75},
		"izquierda_superior": {"unit_type": "royal_marine", "seconds": 2, "probability": 75},
		"izquierda_inferior": {"unit_type": "cannon", "seconds": 3, "probability": 80},
		"derecha_superior": {"unit_type": "royal_marine", "seconds": 2, "probability": 75},
		"derecha_inferior": {"unit_type": "cannon", "seconds": 3, "probability": 80},
	},
		{
		"duration": 6,
		"max_alive": 30,
		"name": "Todo o Nada",
		"add_descanso": false,
		"arriba_izquierda": {"unit_type": "english_cavalry", "seconds": 2, "probability": 75},
		"arriba_centro": {"unit_type": "zapador", "seconds": 2, "probability":100},
		"arriba_derecha": {"unit_type": "english_cavalry", "seconds": 2, "probability": 75},
		"izquierda_superior": {"unit_type": "royal_marine", "seconds": 2, "probability": 75},
		"izquierda_inferior": {"unit_type": "cannon", "seconds": 3, "probability": 80},
		"derecha_superior": {"unit_type": "royal_marine", "seconds": 2, "probability": 75},
		"derecha_inferior": {"unit_type": "cannon", "seconds": 3, "probability": 80},
	},
]
var aDescansos = [
	{
		"duration": 5,
		"max_alive": 0,
		"add_descanso": false,
		"name": "",
		"izquierda_inferior": {"unit_type": "ingles", "seconds": 1, "probability": 0},
		"izquierda_superior": {"unit_type": "ingles", "seconds": 10, "probability": 0},
		"arriba_izquierda": {"unit_type": "ingles", "seconds": 2, "probability": 0},
		"arriba_centro": {"unit_type": "ingles", "seconds": 2, "probability":0},
		"arriba_derecha": {"unit_type": "ingles", "seconds": 2, "probability": 0},
		"derecha_superior": {"unit_type": "ingles", "seconds": 1, "probability": 0},
		"derecha_inferior": {"unit_type": "ingles", "seconds": 1, "probability": 0},
	}
]

func _init():

	iMaxStarters = 60
	iMaxFirstWave = 180
	iMaxSecondWave = 360
	iMaxThirdWave = 540

func get_strategy_card_descanso(iTime):
	var oDescanso = get_one_from(aDescansos)
	return oDescanso

func get_strategy_card(iTime):
	var oCard = null
	if iTime < iMaxStarters:
		oCard = get_one_from(aStarters)
	elif iTime < iMaxFirstWave:
		oCard = get_one_from(aFirstWaves)
	elif iTime < iMaxSecondWave:
		oCard = get_one_from(aSecondWaves)
	elif iTime < iMaxThirdWave:
		oCard = get_one_from(aThirdWaves)
	else:
		oCard = get_one_from(aFinale)
	
	return oCard
	
func get_one_from(aStrategyCards):
	var rng = RandomNumberGenerator.new()
	var iSelectedCard = rng.randi_range(0, aStrategyCards.size() - 1)
	var oCard = aStrategyCards[iSelectedCard]
	return oCard 

func salto_oleada(iTime, iStrategyDuration):
	return nombre_oleada(iTime)!=nombre_oleada(iTime+iStrategyDuration)

func nombre_oleada(iTime):
	#devuelve nombre de oleada que corresponde al tiempo transcurrido
	var sNombre_oleada
	if iTime<iMaxStarters:
		sNombre_oleada = "Starters"
	elif iTime< iMaxFirstWave:
		sNombre_oleada = "FirstWave"
	elif iTime< iMaxSecondWave:
		sNombre_oleada = "SecondWave"
	elif iTime < iMaxThirdWave:
		sNombre_oleada = "ThirdWave"
	else:
		sNombre_oleada = "FinalWave"
	return sNombre_oleada

func create_strategy():
	var created_strategy = []
	var iTime = 0
	var oCard 
	var iDuration
	var oEnglishStrategy
	var oCardDescanso 
	var oEnglishStrategyDescanso

	while iTime < iMaxTime: 
		print("INICIO ITERACION ", iTime)
		oCard = get_strategy_card(iTime)
		
		if salto_oleada(iTime, oCard.duration):
			oCardDescanso = get_strategy_card_descanso(iTime)
			iDuration = oCardDescanso.duration
			iTime += iDuration
			print("DESCANSO ", iTime)
			print("DURACION ", iDuration)
			print("MAX_TIME ", iTime)
			oEnglishStrategyDescanso = duplicate_card(oCardDescanso)
			oEnglishStrategyDescanso.max_time = iTime
			created_strategy.push_back(oEnglishStrategyDescanso)
		iDuration = oCard.duration
		iTime += iDuration
		print("NOMBRE ", oCard.name)
		print("DURACION ", iDuration)
		print("MAX_TIME ", iTime)
		oEnglishStrategy = duplicate_card(oCard)
		oEnglishStrategy.max_time = iTime
		created_strategy.push_back(oEnglishStrategy)
	print(created_strategy)
	return created_strategy

func duplicate_card(oCard):
	return str_to_var(var_to_str(oCard))

extends Node;
var iMaxTime = 600
var iMaxStarters = 60
var iMaxFirstWave = 180
var iMaxSecondWave = 300
var iMaxThirdWave = 420


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
		"max_alive": 20,
		"name": "_ASALTO_FRONTAL_",
		"add_descanso": false,
		"arriba_izquierda": {"unit_type": "ingles", "seconds": 1, "probability": 80},
		"arriba_centro": {"unit_type": "ingles", "seconds": 1, "probability":100},
		"arriba_derecha": {"unit_type": "ingles", "seconds": 1, "probability": 80},
		"izquierda_superior": {"unit_type": "ingles", "seconds": 2, "probability": 80},
		"izquierda_inferior": {"unit_type": "ingles", "seconds": 1, "probability": 0},
		"derecha_superior": {"unit_type": "ingles", "seconds": 2, "probability": 80},
		"derecha_inferior": {"unit_type": "ingles", "seconds": 1, "probability": 0},
	},
	{
		"duration": 6,
		"max_alive": 10,
		"name": "_MARCHA_DE_LOS_HIGHLANDER_",
		"add_descanso": false,
		"arriba_izquierda": {"unit_type": "highlander", "seconds": 1, "probability": 60},
		"arriba_centro": {"unit_type": "highlander", "seconds": 1, "probability":100},
		"arriba_derecha": {"unit_type": "highlander", "seconds": 1, "probability": 60},
		"izquierda_superior": {"unit_type": "ingles", "seconds": 2, "probability": 0},
		"izquierda_inferior": {"unit_type": "ingles", "seconds": 3, "probability": 0},
		"derecha_superior": {"unit_type": "ingles", "seconds": 2, "probability": 0},
		"derecha_inferior": {"unit_type": "ingles", "seconds": 3, "probability": 0},
	},
	
	{
		"duration": 6,
		"max_alive": 15,
		"name": "_VIENTO_OESTE_",
		"add_descanso": false,
		"arriba_izquierda": {"unit_type": "green_soldier", "seconds": 5, "probability": 50},
		"arriba_centro": {"unit_type": "ingles", "seconds": 5, "probability":50},
		"arriba_derecha": {"unit_type": "ingles", "seconds": 5, "probability": 0},
		"izquierda_superior": {"unit_type": "green_soldier", "seconds": 5, "probability": 50},
		"izquierda_inferior": {"unit_type": "green_soldier", "seconds": 5, "probability": 10},
		"derecha_superior": {"unit_type": "ingles", "seconds": 5, "probability": 0},
		"derecha_inferior": {"unit_type": "ingles", "seconds": 5, "probability": 0},
	},
	{
		"duration": 5,
		"max_alive": 15,
		"name": "_VIENTO_ESTE_",
		"add_descanso": false,
		"arriba_izquierda": {"unit_type": "ingles", "seconds": 3, "probability": 0},
		"arriba_centro": {"unit_type": "ingles", "seconds": 5, "probability":50},
		"arriba_derecha": {"unit_type": "green_soldier", "seconds": 5, "probability": 50},
		"izquierda_superior": {"unit_type": "ingles", "seconds": 5, "probability": 0},
		"izquierda_inferior": {"unit_type": "ingles", "seconds": 3, "probability": 0},
		"derecha_superior": {"unit_type": "green_soldier", "seconds": 5, "probability": 50},
		"derecha_inferior": {"unit_type": "green_soldier", "seconds": 5, "probability": 10},
	},
]
var aFirstWaves = [
	{
		"duration": 10,
		"max_alive": 40,
		"name": "_ALTA_PROBABILIDAD_DE_LLUVIAS_",
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
		"max_alive": 30,
		"name": "_LOS_HIGHLANDER_CONTRAATACAN_",
		"add_descanso": false,
		"arriba_izquierda": {"unit_type": "highlander", "seconds": 1, "probability": 75},
		"arriba_centro": {"unit_type": "highlander", "seconds": 1, "probability":100},
		"arriba_derecha": {"unit_type": "highlander", "seconds": 1, "probability": 75},
		"izquierda_superior": {"unit_type": "ingles", "seconds": 2, "probability": 60},
		"izquierda_inferior": {"unit_type": "ingles", "seconds": 3, "probability": 50},
		"derecha_superior": {"unit_type": "ingles", "seconds": 2, "probability": 60},
		"derecha_inferior": {"unit_type": "ingles", "seconds": 3, "probability": 50},
	},
	#{
		#"duration": 6,
		#"max_alive": 30,
		#"name": "_BANDERA_DE_PIRATA_",
		#"add_descanso": false,
		#"arriba_izquierda": {"unit_type": "ingles", "seconds": 1, "probability": 60},
		#"arriba_centro": {"unit_type": "flagger", "seconds": 6, "probability":100, "guards": {"unit_type":"highlander", "quantity": 4}},
		#"arriba_derecha": {"unit_type": "ingles", "seconds": 1, "probability": 60},
		#"izquierda_superior": {"unit_type": "ingles", "seconds": 2, "probability": 40},
		#"izquierda_inferior": {"unit_type": "ingles", "seconds": 3, "probability": 50},
		#"derecha_superior": {"unit_type": "ingles", "seconds": 2, "probability": 40},
		#"derecha_inferior": {"unit_type": "ingles", "seconds": 3, "probability": 50},
	#},
	{
		"duration": 6,
		"max_alive": 20,
		"name": "_PASO_DOBLE_",
		"add_descanso": false,
		"arriba_izquierda": {"unit_type": "green_soldier", "seconds": 2, "probability": 50},
		"arriba_centro": {"unit_type": "green_soldier", "seconds": 2, "probability":50},
		"arriba_derecha": {"unit_type": "green_soldier", "seconds": 3, "probability": 20},
		"izquierda_superior": {"unit_type": "green_soldier", "seconds": 2, "probability": 50},
		"izquierda_inferior": {"unit_type": "green_soldier", "seconds": 2, "probability": 10},
		"derecha_superior": {"unit_type": "green_soldier", "seconds": 2, "probability": 0},
		"derecha_inferior": {"unit_type": "green_soldier", "seconds": 3, "probability": 0},
	},
	{
		"duration": 6,
		"max_alive": 20,
		"name": "_PASO_DOBLE_",
		"add_descanso": false,
		"arriba_izquierda": {"unit_type": "green_soldier", "seconds": 3, "probability": 20},
		"arriba_centro": {"unit_type": "green_soldier", "seconds": 2, "probability":50},
		"arriba_derecha": {"unit_type": "green_soldier", "seconds": 2, "probability": 50},
		"izquierda_superior": {"unit_type": "green_soldier", "seconds": 2, "probability": 0},
		"izquierda_inferior": {"unit_type": "green_soldier", "seconds": 3, "probability": 0},
		"derecha_superior": {"unit_type": "green_soldier", "seconds": 2, "probability": 50},
		"derecha_inferior": {"unit_type": "green_soldier", "seconds": 2, "probability": 10},
	},
]
var aSecondWaves = [
	{
		"duration": 6,
		"max_alive": 40,
		"name": "_CASACAS_ROJAS_",
		"add_descanso": false,
		"arriba_izquierda": {"unit_type": "royal_marine", "seconds": 4, "probability": 100},
		"arriba_centro": {"unit_type": "highlander", "seconds": 3, "probability": 75},
		"arriba_derecha": {"unit_type": "highlander", "seconds": 3, "probability": 75},
		"izquierda_superior": {"unit_type": "ingles", "seconds": 2, "probability": 75},
		"izquierda_inferior": {"unit_type": "ingles", "seconds": 1, "probability": 0},
		"derecha_superior": {"unit_type": "ingles", "seconds": 2, "probability": 0},
		"derecha_inferior": {"unit_type": "ingles", "seconds": 1, "probability": 0},
	},
	#{
		#"duration": 6,
		#"max_alive": 50,
		#"name": "_BANDERA_DE_PIRATA_",
		#"add_descanso": false,
		#"arriba_izquierda": {"unit_type": "ingles", "seconds": 1, "probability": 60},
		#"arriba_centro": {"unit_type": "flagger", "seconds": 6, "probability":100, "guards": {"unit_type":"highlander", "quantity": 4}},
		#"arriba_derecha": {"unit_type": "ingles", "seconds": 1, "probability": 60},
		#"izquierda_superior": {"unit_type": "ingles", "seconds": 2, "probability": 40},
		#"izquierda_inferior": {"unit_type": "ingles", "seconds": 3, "probability": 50},
		#"derecha_superior": {"unit_type": "ingles", "seconds": 2, "probability": 40},
		#"derecha_inferior": {"unit_type": "ingles", "seconds": 3, "probability": 50},
	#},
	{
		"duration": 6,
		"max_alive": 40,
		"name": "_CASACAS_ROJAS_",
		"add_descanso": false,
		"arriba_izquierda": {"unit_type": "highlander", "seconds": 3, "probability": 75},
		"arriba_centro": {"unit_type": "highlander", "seconds": 3, "probability": 75},
		"arriba_derecha": {"unit_type": "royal_marine", "seconds": 4, "probability": 100},
		"izquierda_superior": {"unit_type": "ingles", "seconds": 2, "probability": 0},
		"izquierda_inferior": {"unit_type": "ingles", "seconds": 1, "probability": 0},
		"derecha_superior": {"unit_type": "ingles", "seconds": 2, "probability": 75},
		"derecha_inferior": {"unit_type": "ingles", "seconds": 1, "probability": 0},
	},
	{
		"duration": 6,
		"max_alive": 40,
		"name": "_PIRATAS_VELOCES_",
		"add_descanso": false,
		"arriba_izquierda": {"unit_type": "green_soldier", "seconds": 2, "probability": 75},
		"arriba_centro": {"unit_type": "green_soldier", "seconds": 2, "probability":75},
		"arriba_derecha": {"unit_type": "royal_marine", "seconds": 4, "probability": 100},
		"izquierda_superior": {"unit_type": "green_soldier", "seconds": 2, "probability": 75},
		"izquierda_inferior": {"unit_type": "ingles", "seconds": 2, "probability": 0},
		"derecha_superior": {"unit_type": "ingles", "seconds": 2, "probability": 50},
		"derecha_inferior": {"unit_type": "ingles", "seconds": 2, "probability": 50},
	},
	{
		"duration": 6,
		"max_alive": 40,
		"name": "_PIRATAS_VELOCES_",
		"add_descanso": false,
		"arriba_izquierda": {"unit_type": "royal_marine", "seconds": 4, "probability": 100},
		"arriba_centro": {"unit_type": "green_soldier", "seconds": 2, "probability":75},
		"arriba_derecha": {"unit_type": "green_soldier", "seconds": 2, "probability": 75},
		"izquierda_superior": {"unit_type": "green_soldier", "seconds": 2, "probability": 50},
		"izquierda_inferior": {"unit_type": "ingles", "seconds": 2, "probability": 50},
		"derecha_superior": {"unit_type": "ingles", "seconds": 2, "probability": 75},
		"derecha_inferior": {"unit_type": "ingles", "seconds": 2, "probability": 0},
	},
	{
		"duration": 6,
		"max_alive": 30,
		"name": "_AVANCE_DE_LA_CABALLERIA_",
		"add_descanso": false,
		"arriba_izquierda": {"unit_type": "ingles", "seconds": 3, "probability": 50},
		"arriba_centro": {"unit_type": "ingles", "seconds": 3, "probability":50},
		"arriba_derecha": {"unit_type": "ingles", "seconds": 3, "probability": 50},
		"izquierda_superior": {"unit_type": "english_cavalry", "seconds": 3, "probability": 100},
		"izquierda_inferior": {"unit_type": "english_cavalry", "seconds": 3, "probability": 100},
		"derecha_superior": {"unit_type": "highlander", "seconds": 2, "probability": 75},
		"derecha_inferior": {"unit_type": "ingles", "seconds": 1, "probability": 0},
	},
	{
		"duration": 6,
		"max_alive": 30,
		"name": "_AVANCE_DE_LA_CABALLERIA_",
		"add_descanso": false,
		"arriba_izquierda": {"unit_type": "ingles", "seconds": 3, "probability": 50},
		"arriba_centro": {"unit_type": "ingles", "seconds": 3, "probability":50},
		"arriba_derecha": {"unit_type": "ingles", "seconds": 3, "probability": 50},
		"izquierda_superior": {"unit_type": "highlander", "seconds": 3, "probability": 75},
		"izquierda_inferior": {"unit_type": "ingles", "seconds": 3, "probability": 0},
		"derecha_superior": {"unit_type": "english_cavalry", "seconds": 3, "probability": 100},
		"derecha_inferior": {"unit_type": "english_cavalry", "seconds": 3, "probability": 100},
	},
]
var aThirdWaves = [
	{
		"duration": 6,
		"max_alive": 60,
		"name": "_EL_ATAQUE_DE_LA_CABALLERIA_",
		"add_descanso": false,
		"arriba_izquierda": {"unit_type": "green_soldier", "seconds": 2, "probability": 75},
		"arriba_centro": {"unit_type": "english_cavalry", "seconds": 3, "probability":100},
		"arriba_derecha": {"unit_type": "highlanders", "seconds": 2, "probability": 75},
		"izquierda_superior": {"unit_type": "ingles", "seconds": 3, "probability": 75},
		"izquierda_inferior": {"unit_type": "ingles", "seconds": 1, "probability": 70},
		"derecha_superior": {"unit_type": "ingles", "seconds": 3, "probability": 75},
		"derecha_inferior": {"unit_type": "ingles", "seconds": 1, "probability": 70},
	},
	{
		"duration": 6,
		"max_alive": 60,
		"name": "_MUCHOS_MARINES_DE_LOS_MANDARINES_",
		"add_descanso": false,
		"arriba_izquierda": {"unit_type": "royal_marine", "seconds": 1, "probability": 100},
		"arriba_centro": {"unit_type": "royal_marine", "seconds": 3, "probability":100},
		"arriba_derecha": {"unit_type": "royal_marine", "seconds": 1, "probability": 100},
		"izquierda_superior": {"unit_type": "highlanders", "seconds": 3, "probability": 100},
		"izquierda_inferior": {"unit_type": "ingles", "seconds": 1, "probability": 100},
		"derecha_superior": {"unit_type": "green_soldier", "seconds": 3, "probability": 100},
		"derecha_inferior": {"unit_type": "ingles", "seconds": 1, "probability": 100},
	},
]

var aFinale = [
	{
		"duration": 6,
		"max_alive": 50,
		"name": "_FINAL_DEMO_",
		"add_descanso": false,
		"arriba_izquierda": {"unit_type": "english_cavalry", "seconds": 2, "probability": 0},
		"arriba_centro": {"unit_type": "zapador", "seconds": 2, "probability":0},
		"arriba_derecha": {"unit_type": "english_cavalry", "seconds": 2, "probability": 0},
		"izquierda_superior": {"unit_type": "royal_marine", "seconds": 2, "probability": 0},
		"izquierda_inferior": {"unit_type": "cannon", "seconds": 3, "probability": 0},
		"derecha_superior": {"unit_type": "royal_marine", "seconds": 2, "probability": 0},
		"derecha_inferior": {"unit_type": "cannon", "seconds": 3, "probability": 0},
	},
#
	#{
		#"duration": 6,
		#"max_alive": 50,
		#"name": "_ATAQUE_FINAL_",
		#"add_descanso": false,
		#"arriba_izquierda": {"unit_type": "english_cavalry", "seconds": 2, "probability": 75},
		#"arriba_centro": {"unit_type": "zapador", "seconds": 2, "probability":100},
		#"arriba_derecha": {"unit_type": "english_cavalry", "seconds": 2, "probability": 75},
		#"izquierda_superior": {"unit_type": "royal_marine", "seconds": 2, "probability": 75},
		#"izquierda_inferior": {"unit_type": "cannon", "seconds": 3, "probability": 80},
		#"derecha_superior": {"unit_type": "royal_marine", "seconds": 2, "probability": 75},
		#"derecha_inferior": {"unit_type": "cannon", "seconds": 3, "probability": 80},
	#},
		#{
		#"duration": 6,
		#"max_alive": 50,
		#"name": "_TODO_O_NADA_",
		#"add_descanso": false,
		#"arriba_izquierda": {"unit_type": "english_cavalry", "seconds": 2, "probability": 75},
		#"arriba_centro": {"unit_type": "zapador", "seconds": 2, "probability":100},
		#"arriba_derecha": {"unit_type": "english_cavalry", "seconds": 2, "probability": 75},
		#"izquierda_superior": {"unit_type": "royal_marine", "seconds": 2, "probability": 75},
		#"izquierda_inferior": {"unit_type": "cannon", "seconds": 2, "probability": 80},
		#"derecha_superior": {"unit_type": "royal_marine", "seconds": 2, "probability": 75},
		#"derecha_inferior": {"unit_type": "cannon", "seconds": 2, "probability": 80},
	#},
	#{
		#"duration": 6,
		#"max_alive": 50,
		#"name": "_MUCHOS_MARINES_DE_LOS_MANDARINES_",
		#"add_descanso": false,
		#"arriba_izquierda": {"unit_type": "royal_marine", "seconds": 2, "probability": 75},
		#"arriba_centro": {"unit_type": "royal_marine", "seconds": 3, "probability":100},
		#"arriba_derecha": {"unit_type": "royal_marine", "seconds": 2, "probability": 75},
		#"izquierda_superior": {"unit_type": "green_soldier", "seconds": 3, "probability": 75},
		#"izquierda_inferior": {"unit_type": "ingles", "seconds": 1, "probability": 50},
		#"derecha_superior": {"unit_type": "green_soldier", "seconds": 3, "probability": 75},
		#"derecha_inferior": {"unit_type": "ingles", "seconds": 1, "probability": 50},
	#},
	#{
		#"duration": 6,
		#"max_alive": 50,
		#"name": "_BALAS_GRATIS_",
		#"add_descanso": false,
		#"arriba_izquierda": {"unit_type": "english_cavalry", "seconds": 1, "probability": 100},
		#"arriba_centro": {"unit_type": "royal_marine", "seconds": 3, "probability":100},
		#"arriba_derecha": {"unit_type": "english_cavalry", "seconds": 1, "probability": 100},
		#"izquierda_superior": {"unit_type": "royal_marine", "seconds": 3, "probability": 100},
		#"izquierda_inferior": {"unit_type": "green_soldier", "seconds": 1, "probability": 75},
		#"derecha_superior": {"unit_type": "royal_marine", "seconds": 3, "probability": 100},
		#"derecha_inferior": {"unit_type": "green_soldier", "seconds": 1, "probability": 75},
	#},
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
		print(oCard)
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
	return created_strategy

func duplicate_card(oCard):
	return str_to_var(var_to_str(oCard))

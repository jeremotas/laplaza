extends Node;
var iMaxTime = 600
var iMaxMids = 0
var iMaxStarters = 0

var aStarters = [
	{
		"duration": 10,
		"max_alive": 5,
		"name": "La avanzada",
		"add_descanso": true,
		"izquierda_inferior": {"unit_type": "ingles", "seconds": 1, "probability": 0},
		"izquierda_superior": {"unit_type": "ingles", "seconds": 10, "probability": 0},
		"arriba_izquierda": {"unit_type": "ingles", "seconds": 2, "probability": 10},
		"arriba_centro": {"unit_type": "ingles", "seconds": 2, "probability":40},
		"arriba_derecha": {"unit_type": "ingles", "seconds": 2, "probability": 10},
		"derecha_superior": {"unit_type": "ingles", "seconds": 1, "probability": 0},
		"derecha_inferior": {"unit_type": "ingles", "seconds": 1, "probability": 0},
	},
	{
		"duration": 10,
		"max_alive": 3,
		"name": "La avanzada veloz",
		"add_descanso": true,
		"izquierda_inferior": {"unit_type": "green_soldier", "seconds": 1, "probability": 0},
		"izquierda_superior": {"unit_type": "green_soldier", "seconds": 10, "probability": 0},
		"arriba_izquierda": {"unit_type": "green_soldier", "seconds": 2, "probability": 10},
		"arriba_centro": {"unit_type": "green_soldier", "seconds": 2, "probability":40},
		"arriba_derecha": {"unit_type": "green_soldier", "seconds": 2, "probability": 10},
		"derecha_superior": {"unit_type": "green_soldier", "seconds": 1, "probability": 0},
		"derecha_inferior": {"unit_type": "green_soldier", "seconds": 1, "probability": 0},
	},
	{
		"duration": 10,
		"max_alive": 5,
		"name": "La avanzada dura",
		"add_descanso": true,
		"izquierda_inferior": {"unit_type": "highlander", "seconds": 1, "probability": 0},
		"izquierda_superior": {"unit_type": "highlander", "seconds": 10, "probability": 0},
		"arriba_izquierda": {"unit_type": "highlander", "seconds": 2, "probability": 10},
		"arriba_centro": {"unit_type": "highlander", "seconds": 2, "probability":40},
		"arriba_derecha": {"unit_type": "highlander", "seconds": 2, "probability": 10},
		"derecha_superior": {"unit_type": "highlander", "seconds": 1, "probability": 0},
		"derecha_inferior": {"unit_type": "highlander", "seconds": 1, "probability": 0},
	},
	{
		"duration": 15,
		"max_alive": 10,
		"name": "El flanqueo",
		"add_descanso": true,
		"izquierda_inferior": {"unit_type": "ingles", "seconds": 2, "probability": 40},
		"izquierda_superior": {"unit_type": "ingles", "seconds": 2, "probability": 40},
		"arriba_izquierda": {"unit_type": "ingles", "seconds": 10, "probability": 0},
		"arriba_centro": {"unit_type": "ingles", "seconds": 0, "probability":0},
		"arriba_derecha": {"unit_type": "ingles", "seconds": 10, "probability": 0},
		"derecha_superior": {"unit_type": "ingles", "seconds": 2, "probability": 40},
		"derecha_inferior": {"unit_type": "ingles", "seconds": 2, "probability": 40},
	},
	{
		"duration": 15,
		"max_alive": 5,
		"name": "El flanqueo veloz",
		"add_descanso": true,
		"izquierda_inferior": {"unit_type": "green_soldier", "seconds": 2, "probability": 40},
		"izquierda_superior": {"unit_type": "green_soldier", "seconds": 2, "probability": 40},
		"arriba_izquierda": {"unit_type": "green_soldier", "seconds": 10, "probability": 0},
		"arriba_centro": {"unit_type": "green_soldier", "seconds": 0, "probability":0},
		"arriba_derecha": {"unit_type": "green_soldier", "seconds": 10, "probability": 0},
		"derecha_superior": {"unit_type": "green_soldier", "seconds": 2, "probability": 40},
		"derecha_inferior": {"unit_type": "green_soldier", "seconds": 2, "probability": 40},
	},
	{
		"duration": 15,
		"max_alive": 10,
		"name": "El flanqueo duro",
		"add_descanso": true,
		"izquierda_inferior": {"unit_type": "highlander", "seconds": 2, "probability": 40},
		"izquierda_superior": {"unit_type": "highlander", "seconds": 2, "probability": 40},
		"arriba_izquierda": {"unit_type": "highlander", "seconds": 10, "probability": 0},
		"arriba_centro": {"unit_type": "highlander", "seconds": 0, "probability":0},
		"arriba_derecha": {"unit_type": "highlander", "seconds": 10, "probability": 0},
		"derecha_superior": {"unit_type": "highlander", "seconds": 2, "probability": 40},
		"derecha_inferior": {"unit_type": "highlander", "seconds": 2, "probability": 40},
	},
]
var aMids = [
	{
		"duration": 60,
		"max_alive": 20,
		"name": "El ataque",
		"add_descanso": true,
		"izquierda_inferior": {"unit_type": "ingles", "seconds": 12, "probability": 0},
		"izquierda_superior": {"unit_type": "ingles", "seconds": 1, "probability": 0},
		"arriba_izquierda": {"unit_type": "ingles", "seconds": 1, "probability": 40},
		"arriba_centro": {"unit_type": "highlander", "seconds": 10, "probability": 10},
		"arriba_derecha": {"unit_type": "ingles", "seconds": 1, "probability": 40},
		"derecha_superior": {"unit_type": "ingles", "seconds": 8, "probability": 0},
		"derecha_inferior": {"unit_type":"ingles", "seconds": 12, "probability": 0},
	},
	{
		"duration": 60,
		"max_alive": 20,
		"name": "El ataque veloz",
		"add_descanso": true,
		"izquierda_inferior": {"unit_type": "ingles", "seconds": 12, "probability": 0},
		"izquierda_superior": {"unit_type": "ingles", "seconds": 1, "probability": 0},
		"arriba_izquierda": {"unit_type": "green_soldier", "seconds": 1, "probability": 40},
		"arriba_centro": {"unit_type": "ingles", "seconds": 10, "probability": 10},
		"arriba_derecha": {"unit_type": "green_soldier", "seconds": 1, "probability": 40},
		"derecha_superior": {"unit_type": "ingles", "seconds": 8, "probability": 0},
		"derecha_inferior": {"unit_type":"ingles", "seconds": 12, "probability": 0},
	},
	{
		"duration": 60,
		"max_alive": 20,
		"name": "El ataque duro",
		"add_descanso": true,
		"izquierda_inferior": {"unit_type": "ingles", "seconds": 12, "probability": 0},
		"izquierda_superior": {"unit_type": "ingles", "seconds": 1, "probability": 0},
		"arriba_izquierda": {"unit_type": "highlander", "seconds": 1, "probability": 40},
		"arriba_centro": {"unit_type": "green_soldier", "seconds": 10, "probability": 10},
		"arriba_derecha": {"unit_type": "highlander", "seconds": 1, "probability": 40},
		"derecha_superior": {"unit_type": "ingles", "seconds": 8, "probability": 0},
		"derecha_inferior": {"unit_type": "ingles", "seconds": 12, "probability": 0},
	},
	{
		"duration": 60,
		"max_alive": 40,
		"name": "El ataque pesado",
		"add_descanso": true,
		"izquierda_inferior": {"unit_type": "ingles", "seconds": 4, "probability": 100},
		"izquierda_superior": {"unit_type": "ingles", "seconds": 1, "probability": 50},
		"arriba_izquierda": {"unit_type": "ingles", "seconds": 1, "probability": 50},
		"arriba_centro": {"unit_type": "highlander", "seconds": 6, "probability": 10},
		"arriba_derecha": {"unit_type": "ingles", "seconds": 1, "probability": 50},
		"derecha_superior": {"unit_type": "ingles", "seconds": 1, "probability": 50},
		"derecha_inferior": {"unit_type": "ingles", "seconds": 1, "probability": 50},
	},
	{
		"duration": 60,
		"max_alive": 40,
		"name": "El ataque pesadamente veloz",
		"add_descanso": true,
		"izquierda_inferior": {"unit_type": "green_soldier", "seconds": 6, "probability": 10},
		"izquierda_superior": {"unit_type": "ingles", "seconds": 1, "probability": 50},
		"arriba_izquierda": {"unit_type": "ingles", "seconds": 1, "probability": 50},
		"arriba_centro": {"unit_type": "green_soldier", "seconds": 6, "probability": 10},
		"arriba_derecha": {"unit_type": "ingles", "seconds": 1, "probability": 50},
		"derecha_superior": {"unit_type": "ingles", "seconds": 1, "probability": 50},
		"derecha_inferior": {"unit_type": "green_soldier", "seconds": 6, "probability": 10},
	}
]
var aFinale = [
	{
		"duration": 30,
		"max_alive": 20,
		"name": "La estampida mortal",
		"add_descanso": true,
		"izquierda_inferior": {"unit_type": "highlander", "seconds": 3, "probability": 70},
		"izquierda_superior": {"unit_type": "green_soldier", "seconds": 4, "probability": 10},
		"arriba_izquierda": {"unit_type": "ingles", "seconds": 4, "probability": 95},
		"arriba_centro": {"unit_type": "highlander", "seconds": 3, "probability": 40},
		"arriba_derecha": {"unit_type": "ingles", "seconds": 3, "probability": 70},
		"derecha_superior": {"unit_type": "green_soldier", "seconds": 4, "probability": 10},
		"derecha_inferior": {"unit_type": "highlander", "seconds": 3, "probability": 70},
	},
	{
		"duration": 30,
		"max_alive": 50,
		"name": "Atención al flanco derecho",
		"add_descanso": true,	
		"izquierda_inferior": {"unit_type": "highlander", "seconds": 3, "probability": 0},
		"izquierda_superior": {"unit_type": "green_soldier", "seconds": 3, "probability": 40},
		"arriba_izquierda": {"unit_type": "ingles", "seconds": 4, "probability": 0},
		"arriba_centro": {"unit_type": "highlander", "seconds": 3, "probability": 40},
		"arriba_derecha": {"unit_type": "ingles", "seconds": 2, "probability": 70},
		"derecha_superior": {"unit_type": "highlander", "seconds": 2, "probability": 70},
		"derecha_inferior": {"unit_type": "ingles", "seconds": 2, "probability": 70},
	},
	{
		"duration": 30,
		"max_alive": 50,
		"name": "Atención al flanco derecho",
		"add_descanso": true,
		"izquierda_inferior": {"unit_type": "highlander", "seconds": 3, "probability": 70},
		"izquierda_superior": {"unit_type": "ingles", "seconds": 3, "probability": 70},
		"arriba_izquierda": {"unit_type": "ingles", "seconds": 4, "probability": 0},
		"arriba_centro": {"unit_type": "highlander", "seconds": 3, "probability": 40},
		"arriba_derecha": {"unit_type": "ingles", "seconds": 2, "probability": 70},
		"derecha_superior": {"unit_type": "green_soldier", "seconds": 3, "probability": 40},
		"derecha_inferior": {"unit_type": "highlander", "seconds": 2, "probability": 0},
	},
	{
		"duration": 30,
		"max_alive": 50,
		"name": "Atención al flanco izquierdo",
		"add_descanso": true,
		"izquierda_inferior": {"unit_type": "highlander", "seconds": 3, "probability": 0},
		"izquierda_superior": {"unit_type": "green_soldier", "seconds": 3, "probability": 40},
		"arriba_izquierda": {"unit_type": "ingles", "seconds": 4, "probability": 0},
		"arriba_centro": {"unit_type": "highlander", "seconds": 3, "probability": 40},
		"arriba_derecha": {"unit_type": "ingles", "seconds": 2, "probability": 70},
		"derecha_superior": {"unit_type": "highlander", "seconds": 2, "probability": 70},
		"derecha_inferior": {"unit_type": "ingles", "seconds": 2, "probability": 70},
	},
	{
		"duration": 30,
		"max_alive": 50,
		"name": "Atención al flanco izquierdo",
		"add_descanso": true,
		"izquierda_inferior": {"unit_type": "highlander", "seconds": 3, "probability": 70},
		"izquierda_superior": {"unit_type": "ingles", "seconds": 3, "probability": 70},
		"arriba_izquierda": {"unit_type": "ingles", "seconds": 4, "probability": 0},
		"arriba_centro": {"unit_type": "highlander", "seconds": 3, "probability": 40},
		"arriba_derecha": {"unit_type": "ingles", "seconds": 2, "probability": 70},
		"derecha_superior": {"unit_type": "green_soldier", "seconds": 3, "probability": 40},
		"derecha_inferior": {"unit_type": "highlander", "seconds": 2, "probability": 0},
	},
	{
		"duration": 30,
		"max_alive": 60,
		"name": "La ola fuerte",
		"add_descanso": true,
		"izquierda_inferior": {"unit_type": "ingles", "seconds": 1.5, "probability": 40},
		"izquierda_superior": {"unit_type": "highlander", "seconds": 2, "probability": 30},
		"arriba_izquierda": {"unit_type": "ingles", "seconds": 2, "probability": 40},
		"arriba_centro": {"unit_type": "highlander", "seconds": 2, "probability": 30},
		"arriba_derecha": {"unit_type": "highlander", "seconds": 1.5, "probability": 40},
		"derecha_superior": {"unit_type": "ingles", "seconds": 1.5, "probability": 40},
		"derecha_inferior": {"unit_type": "highlander", "seconds": 1.5, "probability": 40},
	},
	{
		"duration": 30,
		"max_alive": 3,
		"name": "Cañones",
		"add_descanso": true,
		"izquierda_inferior": {"unit_type": "cannon", "seconds": 1.5, "probability": 20},
		"izquierda_superior": {"unit_type": "cannon", "seconds": 1.5, "probability": 30},
		"arriba_izquierda": {"unit_type": "ingles", "seconds": 2, "probability": 0},
		"arriba_centro": {"unit_type": "highlander", "seconds": 2, "probability": 0},
		"arriba_derecha": {"unit_type": "ingles", "seconds": 1.5, "probability": 0},
		"derecha_superior": {"unit_type": "cannon", "seconds": 1.5, "probability": 30},
		"derecha_inferior": {"unit_type": "cannon", "seconds": 1.5, "probability": 20},
	},
	{
		"duration": 30,
		"max_alive": 8,
		"name": "Cañones duros",
		"add_descanso": true,
		"izquierda_inferior": {"unit_type": "cannon", "seconds": 1.5, "probability": 20},
		"izquierda_superior": {"unit_type": "cannon", "seconds": 1.5, "probability": 30},
		"arriba_izquierda": {"unit_type": "ingles", "seconds": 2, "probability": 0},
		"arriba_centro": {"unit_type": "highlander", "seconds": 2, "probability": 0},
		"arriba_derecha": {"unit_type": "ingles", "seconds": 1.5, "probability": 0},
		"derecha_superior": {"unit_type": "cannon", "seconds": 1.5, "probability": 30},
		"derecha_inferior": {"unit_type": "cannon", "seconds": 1.5, "probability": 20},
	},
	{
		"duration": 60,
		"max_alive": 12,
		"name": "Cañones mortal",
		"add_descanso": true,
		"izquierda_inferior": {"unit_type": "cannon", "seconds": 1.5, "probability": 20},
		"izquierda_superior": {"unit_type": "cannon", "seconds": 1.5, "probability": 30},
		"arriba_izquierda": {"unit_type": "ingles", "seconds": 2, "probability": 0},
		"arriba_centro": {"unit_type": "highlander", "seconds": 2, "probability": 0},
		"arriba_derecha": {"unit_type": "ingles", "seconds": 1.5, "probability": 0},
		"derecha_superior": {"unit_type": "cannon", "seconds": 1.5, "probability": 30},
		"derecha_inferior": {"unit_type": "cannon", "seconds": 1.5, "probability": 20},
	}
]
var aDescansos = [
	{
		"duration": 10,
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
	iMaxStarters = iMaxTime / 3
	iMaxMids = iMaxTime * 2 / 3

func get_strategy_card_descanso(iTime):
	var oDescanso = get_one_from(aDescansos)
	return oDescanso

func get_strategy_card(iTime):
	var oCard = null
	if iTime < iMaxStarters:
		oCard = get_one_from(aStarters)
	elif iTime < iMaxMids:
		oCard = get_one_from(aMids)
	else:
		oCard = get_one_from(aFinale)
	
	return oCard
	
func get_one_from(aStrategyCards):
	var rng = RandomNumberGenerator.new()
	var iSelectedCard = rng.randi_range(0, aStrategyCards.size() - 1)
	var oCard = aStrategyCards[iSelectedCard]
	return oCard 

func create_strategy():
	var created_strategy = []
	var iTime = 0
	while iTime < iMaxTime: 
		print("INICIO ITERACION ", iTime)
		var oCard = get_strategy_card(iTime)
		var iDuration = oCard.duration
		iTime += iDuration
		print("NOMBRE ", oCard.name)
		print("DURACION ", iDuration)
		print("MAX_TIME ", iTime)
		
		var oEnglishStrategy = duplicate_card(oCard)
		oEnglishStrategy.max_time = iTime
		created_strategy.push_back(oEnglishStrategy)
		
		if oCard.add_descanso and iTime < iMaxTime - 120:
			
			var oCardDescanso = get_strategy_card_descanso(iTime)
			iDuration = oCardDescanso.duration
			iTime += iDuration
			print("DESCANSO ", iTime)
			print("DURACION ", iDuration)
			print("MAX_TIME ", iTime)
			var oEnglishStrategyDescanso = duplicate_card(oCardDescanso)
			oEnglishStrategyDescanso.max_time = iTime
			created_strategy.push_back(oEnglishStrategyDescanso)
		
	print(created_strategy)
	return created_strategy	

func duplicate_card(oCard):
	return str_to_var(var_to_str(oCard))

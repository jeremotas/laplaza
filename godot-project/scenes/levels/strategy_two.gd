extends Node;

var descanso = {
			"max_time": 15,
			"max_alive": 0,
			"name": "",
			"izquierda_inferior": {"unit_type": "ingles", "seconds": 1, "probability": 0},
			"izquierda_superior": {"unit_type": "ingles", "seconds": 10, "probability": 0},
			"arriba_izquierda": {"unit_type": "ingles", "seconds": 2, "probability": 0},
			"arriba_centro": {"unit_type": "ingles", "seconds": 2, "probability":0},
			"arriba_derecha": {"unit_type": "ingles", "seconds": 2, "probability": 0},
			"derecha_superior": {"unit_type": "ingles", "seconds": 1, "probability": 0},
			"derecha_inferior": {"unit_type": "ingles", "seconds": 1, "probability": 0},
		}

var strategy = [
		{
			"max_time": 10,
			"max_alive": 5,
			"name": "La avanzada",
			"izquierda_inferior": {"unit_type": "ingles", "seconds": 1, "probability": 0},
			"izquierda_superior": {"unit_type": "ingles", "seconds": 10, "probability": 0},
			"arriba_izquierda": {"unit_type": "ingles", "seconds": 2, "probability": 10},
			"arriba_centro": {"unit_type": "ingles", "seconds": 2, "probability":40},
			"arriba_derecha": {"unit_type": "ingles", "seconds": 2, "probability": 10},
			"derecha_superior": {"unit_type": "ingles", "seconds": 1, "probability": 0},
			"derecha_inferior": {"unit_type": "ingles", "seconds": 1, "probability": 0},
		},
		{
			"max_time": 30,
			"max_alive": 10,
			"name": "El flanqueo",
			"izquierda_inferior": {"unit_type": "ingles", "seconds": 2, "probability": 40},
			"izquierda_superior": {"unit_type": "ingles", "seconds": 2, "probability": 40},
			"arriba_izquierda": {"unit_type": "ingles", "seconds": 10, "probability": 0},
			"arriba_centro": {"unit_type": "ingles", "seconds": 0, "probability":0},
			"arriba_derecha": {"unit_type": "ingles", "seconds": 10, "probability": 0},
			"derecha_superior": {"unit_type": "ingles", "seconds": 2, "probability": 40},
			"derecha_inferior": {"unit_type": "ingles", "seconds": 2, "probability": 40},
		},
		
		{
			"max_time": 120,
			"max_alive": 20,
			"name": "El ataque",
			"izquierda_inferior": {"unit_type": "ingles", "seconds": 12, "probability": 0},
			"izquierda_superior": {"unit_type": "ingles", "seconds": 1, "probability": 0},
			"arriba_izquierda": {"unit_type": "ingles", "seconds": 1, "probability": 40},
			"arriba_centro": {"unit_type": "highlander", "seconds": 10, "probability": 10},
			"arriba_derecha": {"unit_type": "ingles", "seconds": 1, "probability": 40},
			"derecha_superior": {"unit_type": "ingles", "seconds": 8, "probability": 0},
			"derecha_inferior": {"unit_type":"ingles", "seconds": 12, "probability": 0},
		},
		
		{
			"max_time": 180,
			"max_alive": 40,
			"name": "El segundo ataque",
			"izquierda_inferior": {"unit_type": "ingles", "seconds": 4, "probability": 100},
			"izquierda_superior": {"unit_type": "ingles", "seconds": 1, "probability": 50},
			"arriba_izquierda": {"unit_type": "ingles", "seconds": 1, "probability": 50},
			"arriba_centro": {"unit_type": "highlander", "seconds": 6, "probability": 10},
			"arriba_derecha": {"unit_type": "ingles", "seconds": 1, "probability": 50},
			"derecha_superior": {"unit_type": "ingles", "seconds": 1, "probability": 50},
			"derecha_inferior": {"unit_type": "ingles", "seconds": 1, "probability": 50},
		},
		
		{
			"max_time": 240,
			"max_alive": 60,
			"name": "El ataque feroz",
			"izquierda_inferior": {"unit_type": "green_soldier", "seconds": 3, "probability": 40},
			"izquierda_superior": {"unit_type": "ingles", "seconds": 1, "probability": 40},
			"arriba_izquierda": {"unit_type": "ingles", "seconds": 1, "probability": 40},
			"arriba_centro": {"unit_type": "highlander", "seconds": 2, "probability": 5},
			"arriba_derecha": {"unit_type": "ingles", "seconds": 1, "probability": 20},
			"derecha_superior": {"unit_type": "green_soldier", "seconds": 3, "probability": 20},
			"derecha_inferior": {"unit_type": [{"unit_type":"highlander", "probability": 30}, {"unit_type":"ingles", "probability": 70}], "seconds": 1, "probability": 20},
		},
		
		{
			"max_time": 300,
			"max_alive": 20,
			"name": "La estampida mortal",
			"izquierda_inferior": {"unit_type": "highlander", "seconds": 3, "probability": 70},
			"izquierda_superior": {"unit_type": "ingles", "seconds": 3, "probability": 40},
			"arriba_izquierda": {"unit_type": "ingles", "seconds": 4, "probability": 95},
			"arriba_centro": {"unit_type": "highlander", "seconds": 3, "probability": 40},
			"arriba_derecha": {"unit_type": "ingles", "seconds": 3, "probability": 70},
			"derecha_superior": {"unit_type": "ingles", "seconds": 3, "probability": 70},
			"derecha_inferior": {"unit_type": "highlander", "seconds": 3, "probability": 70},
		},
		
		{
			"max_time": 380,
			"max_alive": 50,
			"name": "Atención al flanco derecho",
			"izquierda_inferior": {"unit_type": "highlander", "seconds": 3, "probability": 0},
			"izquierda_superior": {"unit_type": "green_soldier", "seconds": 3, "probability": 40},
			"arriba_izquierda": {"unit_type": "ingles", "seconds": 4, "probability": 0},
			"arriba_centro": {"unit_type": "highlander", "seconds": 3, "probability": 40},
			"arriba_derecha": {"unit_type": "ingles", "seconds": 2, "probability": 70},
			"derecha_superior": {"unit_type": "highlander", "seconds": 2, "probability": 70},
			"derecha_inferior": {"unit_type": "ingles", "seconds": 2, "probability": 70},
		},
		{
			"max_time": 540,
			"max_alive": 100,
			"name": "La última ola",
			"izquierda_inferior": {"unit_type": "ingles", "seconds": 1.5, "probability": 40},
			"izquierda_superior": {"unit_type": "highlander", "seconds": 2, "probability": 30},
			"arriba_izquierda": {"unit_type": "ingles", "seconds": 2, "probability": 40},
			"arriba_centro": {"unit_type": "highlander", "seconds": 2, "probability": 30},
			"arriba_derecha": {"unit_type": "highlander", "seconds": 1.5, "probability": 40},
			"derecha_superior": {"unit_type": "ingles", "seconds": 1.5, "probability": 40},
			"derecha_inferior": {"unit_type": "highlander", "seconds": 1.5, "probability": 40},
		}
	]
var rng

func _init():
	rng = RandomNumberGenerator.new()
	
	
func prepare_unit_types():
	var aUnitsTypes = [{"unit_type":"highlander", "probability": 0}, {"unit_type":"ingles", "probability": 0}, {"unit_type":"green_soldier", "probability": 0}]
	
	# Probabilidad de unidades
	var iProbabilityIngles = rng.randi_range(0, 100)
	var iProbabilityHighlander = rng.randi_range(0, 100 - iProbabilityIngles)
	var iProbabilityGreenSoldier = 100 - iProbabilityIngles - iProbabilityHighlander
	aUnitsTypes[0].probability = iProbabilityHighlander
	aUnitsTypes[1].probability = iProbabilityIngles
	aUnitsTypes[2].probability = iProbabilityGreenSoldier
	
	return aUnitsTypes.duplicate()
	
func create_strategy_attack_name(iLeft, iTop, iRight, iLevel):
	var sName = ''
	var aNames = []
	if iLeft == 1 and iTop == 1 and iRight == 1:
		aNames = ["¡De todos lados!", "El infierno", "Superola", "La orda"]
	elif iLeft == 1 and iRight == 1:
		aNames = ["Flanqueos", "De lados", "Ataques laterales", "Ataque de los lados"]
	elif iTop == 1 and iRight == 1:
		aNames = ["Derecha y frente", "Fresco y batata", "Cabildo derechoso"]
	elif iTop == 1 and iLeft == 1:
		aNames = ["Izquierda y cabildo", "Juramento y Cabildo", "Zurdas cabildosas"]
	elif iTop == 1:
		aNames = ["Desde el cabildo", "Ingleses cabildosos", "Cabildean", "Atacan desde el cabildo"]
	elif iLeft == 1:
		aNames = ["La zurda", "Desde la izquierda", "Lateral izquierdo", "Se viene el zurdaje"]
	elif iRight == 1:
		aNames = ["La derecha", "La derecha recalcitrante", "Lateral derecho", "Derechitos"]
		
	sName = aNames[rng.randi_range(0, aNames.size() - 1)]
	return sName
	
func create_one_strategy_attack(iLevel):
	var oStrategyAttack = {
		"max_time": 0,
		"max_alive": 0,
		"name": "---",
		"izquierda_inferior": {"unit_type": [], "seconds": 0, "probability": 0},
		"izquierda_superior": {"unit_type": [], "seconds": 0, "probability": 0},
		"arriba_izquierda": {"unit_type": [], "seconds": 0, "probability": 0},
		"arriba_centro": {"unit_type": [], "seconds": 0, "probability": 0},
		"arriba_derecha": {"unit_type": [], "seconds": 0, "probability": 0},
		"derecha_superior": {"unit_type": [], "seconds": 0, "probability": 0},
		"derecha_inferior": {"unit_type": [], "seconds": 0, "probability": 0},
	}
	
	var aMS = [
		{"iBottomSpawnSeconds": 3, "iTopSpawnSeconds": 4, "iBottomSpawnProbability": 10, "iTopSpawnProbability": 40, "iBottomAlive": 10, "iTopAlive": 30},
		{"iBottomSpawnSeconds": 3, "iTopSpawnSeconds": 4, "iBottomSpawnProbability": 20, "iTopSpawnProbability": 40, "iBottomAlive": 20, "iTopAlive": 40},
		{"iBottomSpawnSeconds": 2, "iTopSpawnSeconds": 4, "iBottomSpawnProbability": 20, "iTopSpawnProbability": 40, "iBottomAlive": 30, "iTopAlive": 50},
		{"iBottomSpawnSeconds": 2, "iTopSpawnSeconds": 3, "iBottomSpawnProbability": 20, "iTopSpawnProbability": 40, "iBottomAlive": 40, "iTopAlive": 60},
		{"iBottomSpawnSeconds": 2, "iTopSpawnSeconds": 3, "iBottomSpawnProbability": 30, "iTopSpawnProbability": 50, "iBottomAlive": 50, "iTopAlive": 70},
		{"iBottomSpawnSeconds": 2, "iTopSpawnSeconds": 3, "iBottomSpawnProbability": 30, "iTopSpawnProbability": 60, "iBottomAlive": 60, "iTopAlive": 80},
		{"iBottomSpawnSeconds": 1, "iTopSpawnSeconds": 3, "iBottomSpawnProbability": 40, "iTopSpawnProbability": 60, "iBottomAlive": 70, "iTopAlive": 90},
		{"iBottomSpawnSeconds": 1, "iTopSpawnSeconds": 3, "iBottomSpawnProbability": 50, "iTopSpawnProbability": 70, "iBottomAlive": 80, "iTopAlive": 100},
		{"iBottomSpawnSeconds": 1, "iTopSpawnSeconds": 3, "iBottomSpawnProbability": 50, "iTopSpawnProbability": 70, "iBottomAlive": 80, "iTopAlive": 100},
		{"iBottomSpawnSeconds": 1, "iTopSpawnSeconds": 3, "iBottomSpawnProbability": 50, "iTopSpawnProbability": 70, "iBottomAlive": 80, "iTopAlive": 100},
		{"iBottomSpawnSeconds": 1, "iTopSpawnSeconds": 3, "iBottomSpawnProbability": 50, "iTopSpawnProbability": 70, "iBottomAlive": 80, "iTopAlive": 100},
		{"iBottomSpawnSeconds": 1, "iTopSpawnSeconds": 3, "iBottomSpawnProbability": 50, "iTopSpawnProbability": 70, "iBottomAlive": 80, "iTopAlive": 100},
		{"iBottomSpawnSeconds": 1, "iTopSpawnSeconds": 3, "iBottomSpawnProbability": 50, "iTopSpawnProbability": 70, "iBottomAlive": 80, "iTopAlive": 100},
		#{"iBottomSpawnSeconds": 1, "iTopSpawnSeconds": 3, "iBottomSpawnProbability": 60, "iTopSpawnProbability": 70, "iBottomAlive": 90, "iTopAlive": 120},
		#{"iBottomSpawnSeconds": 1, "iTopSpawnSeconds": 3, "iBottomSpawnProbability": 70, "iTopSpawnProbability": 80, "iBottomAlive": 100, "iTopAlive": 150},
		#{"iBottomSpawnSeconds": 1, "iTopSpawnSeconds": 3, "iBottomSpawnProbability": 70, "iTopSpawnProbability": 80, "iBottomAlive": 150, "iTopAlive": 200},
		#{"iBottomSpawnSeconds": 1, "iTopSpawnSeconds": 3, "iBottomSpawnProbability": 70, "iTopSpawnProbability": 80, "iBottomAlive": 200, "iTopAlive": 250},
		#{"iBottomSpawnSeconds": 1, "iTopSpawnSeconds": 3, "iBottomSpawnProbability": 70, "iTopSpawnProbability": 80, "iBottomAlive": 200, "iTopAlive": 250},
		#{"iBottomSpawnSeconds": 1, "iTopSpawnSeconds": 3, "iBottomSpawnProbability": 70, "iTopSpawnProbability": 80, "iBottomAlive": 200, "iTopAlive": 250},
		#{"iBottomSpawnSeconds": 1, "iTopSpawnSeconds": 3, "iBottomSpawnProbability": 70, "iTopSpawnProbability": 80, "iBottomAlive": 200, "iTopAlive": 250},
	]
	
	var MS = aMS[iLevel]
	
	var iMaxAlive = rng.randi_range(MS.iBottomAlive, MS.iTopAlive)
	
	var iTop = 0
	var iLeft = 0
	var iRight = 0
	
	# Determino los sectores de ataque
	if iLevel > 5:
		iTop = 1
		iLeft = 1
		iRight = 1
	elif iLevel < 2:
		iTop = 1
	else:
		iTop = rng.randi_range(0, 1)
		if iTop == 0: 
			iLeft = 1
			iRight = 1
		else:
			iLeft = rng.randi_range(0, 1)
			if iLeft == 0:
				iRight = 1
	
	if iLeft == 1:
		var iSpawnSeconds = rng.randi_range(MS.iBottomSpawnSeconds, MS.iTopSpawnSeconds)
		var iSpawnProbability = rng.randi_range(MS.iBottomSpawnProbability, MS.iTopSpawnProbability)
		oStrategyAttack.izquierda_inferior = {"unit_type": prepare_unit_types(), "seconds": iSpawnSeconds, "probability": iSpawnProbability}
		iSpawnSeconds = rng.randi_range(MS.iBottomSpawnSeconds, MS.iTopSpawnSeconds)
		iSpawnProbability = rng.randi_range(MS.iBottomSpawnProbability, MS.iTopSpawnProbability)
		oStrategyAttack.izquierda_superior = {"unit_type": prepare_unit_types(), "seconds": iSpawnSeconds, "probability": iSpawnProbability}
		
	if iRight == 1:	
		var iSpawnSeconds = rng.randi_range(MS.iBottomSpawnSeconds, MS.iTopSpawnSeconds)
		var iSpawnProbability = rng.randi_range(MS.iBottomSpawnProbability, MS.iTopSpawnProbability)
		oStrategyAttack.derecha_inferior = {"unit_type": prepare_unit_types(), "seconds": iSpawnSeconds, "probability": iSpawnProbability}
		iSpawnSeconds = rng.randi_range(MS.iBottomSpawnSeconds, MS.iTopSpawnSeconds)
		iSpawnProbability = rng.randi_range(MS.iBottomSpawnProbability, MS.iTopSpawnProbability)
		oStrategyAttack.derecha_superior = {"unit_type": prepare_unit_types(), "seconds": iSpawnSeconds, "probability": iSpawnProbability}
		
	if iTop == 1:	
		var iSpawnSeconds = rng.randi_range(MS.iBottomSpawnSeconds, MS.iTopSpawnSeconds)
		var iSpawnProbability = rng.randi_range(MS.iBottomSpawnProbability, MS.iTopSpawnProbability)
		oStrategyAttack.arriba_izquierda = {"unit_type": prepare_unit_types(), "seconds": iSpawnSeconds, "probability": iSpawnProbability}
		iSpawnSeconds = rng.randi_range(MS.iBottomSpawnSeconds, MS.iTopSpawnSeconds)
		iSpawnProbability = rng.randi_range(MS.iBottomSpawnProbability, MS.iTopSpawnProbability)
		oStrategyAttack.arriba_centro = {"unit_type": prepare_unit_types(), "seconds": iSpawnSeconds, "probability": iSpawnProbability}
		iSpawnSeconds = rng.randi_range(MS.iBottomSpawnSeconds, MS.iTopSpawnSeconds)
		iSpawnProbability = rng.randi_range(MS.iBottomSpawnProbability, MS.iTopSpawnProbability)
		oStrategyAttack.arriba_derecha = {"unit_type": prepare_unit_types(), "seconds": iSpawnSeconds, "probability": iSpawnProbability}
		
	
	oStrategyAttack.max_alive = iMaxAlive
	oStrategyAttack.name = create_strategy_attack_name(iLeft, iTop, iRight, iLevel)
	
	
	return oStrategyAttack.duplicate()

func create_strategy():
	var created_strategy = []
	var iTime = 0
	var iMin = 15
	var iMax = 30
	var iDuration = 0
	var bDescanso = true
	var iDescansoMin = 10
	var iDescansoMax = 20
	while iTime < 600: 
		
		# Determino duracion de la wave segun el momento
		if iTime < 60:
			iMin = 15
			iMax = 30
			bDescanso = true
		elif iTime < 300:
			iMin = 40
			iMax = 100
			bDescanso = true
		else:
			iMin = 40
			iMax = 100
			bDescanso = false
		
		iDuration = rng.randi_range(iMin, iMax)
		iTime += iDuration
		var oEnglishStrategy = create_one_strategy_attack(iTime / 60 + 1)
		oEnglishStrategy.max_time = iTime
		created_strategy.push_back(oEnglishStrategy)
		
		if bDescanso:
			var oDescanso = descanso.duplicate()
			var iDurationDescanso = rng.randi_range(iDescansoMin, iDescansoMax)
			iTime += iDurationDescanso
			oDescanso.max_time = iTime
			created_strategy.push_back(oDescanso)
		
		
	print(created_strategy)
	return created_strategy	

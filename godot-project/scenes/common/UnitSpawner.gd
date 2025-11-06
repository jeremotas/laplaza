extends Marker2D
var entity = null
@export var zone = ""
@export var probabilitySpawnOnTimer = 20.0
@export var spawnOnReady = true
@export var unitScene = "res://scenes/patricios/granadero.tscn"
@export var faction = ""
@export var respawn_seconds = 2.5
@export var max_alive = 0
@export var controlled_max_alive = false
@export var blocked = false

@export var oOtherParams = {}


var queue = []

var rng = RandomNumberGenerator.new()
var oGoalToAssign = null
var aChanceUnitType = []

func _ready():
	entity = load(unitScene)
	$TimerDeSpawnUnidades.start(respawn_seconds)
	if faction == 'ingleses':
		$SpawnSpriteEnemigo.visible = true
		if zone != "":
			add_to_group("spawn_" + zone)
			if get_parent().has_method('add_spawn_zone'):
				get_parent().add_spawn_zone(zone)
			
	if spawnOnReady:
		spawn_new_call(probabilitySpawnOnTimer)
	
	
func set_other_parameters(oOtherParamsVal):
	oOtherParams = oOtherParamsVal
		
func set_unit_type(mUnitType):
	aChanceUnitType = []
	if typeof(mUnitType) == TYPE_STRING:
		unitScene = "res://scenes/" + faction + "/" + mUnitType + ".tscn"
		entity = load(unitScene)
	elif typeof(mUnitType) == TYPE_ARRAY:
		create_chance_unit_type(mUnitType)
	
func create_chance_unit_type(aChanceUnitTypeParam):
	for oChance in aChanceUnitTypeParam:
		for i in range(oChance.probability):
			aChanceUnitType.push_back(oChance.unit_type)
	#print(aChanceUnitType.size())

func spawn_unit(unitSceneAsked):
	var unitSceneOld = unitScene
	entity = load(unitSceneAsked)
	spawn_new_call(100.0)
	unitScene = unitSceneOld

func set_rewspan_seconds(respawn_seconds_new):
	respawn_seconds = respawn_seconds_new
	$TimerDeSpawnUnidades.start(respawn_seconds)

func set_goal(oGoal):
	oGoalToAssign = oGoal

func load_unit_by_chance():
	var sUnitTypeSelected = ""
	var iSelectedUnit = rng.randi_range(0, aChanceUnitType.size() - 1)
	sUnitTypeSelected = aChanceUnitType[iSelectedUnit]
	unitScene = "res://scenes/" + faction + "/" + sUnitTypeSelected + ".tscn"
	entity = load(unitScene)
	#("Elegi random: ", sUnitTypeSelected)
	return sUnitTypeSelected

func spawn_new_call(probability_generation):
	var value_creation = rng.randf_range(0.0, 100.0)
	var can_spawn = not controlled_max_alive or max_alive >= get_tree().get_nodes_in_group("faccion_" + faction).size()
	if can_spawn and not $SpawnArea.has_overlapping_bodies() and value_creation <= probability_generation and not blocked:
		
		if aChanceUnitType.size() > 0:
			load_unit_by_chance()
			
		var soldado = entity.instantiate();
		var aPossibleSpawns = get_possible_spawns()
		var iSelected = rng.randi_range(0, aPossibleSpawns.size() - 1)
		var start_position = aPossibleSpawns[iSelected]
		
		soldado.global_position = start_position
		soldado.add_to_faction(faction)
		soldado = assign_other_params(soldado)
		if soldado.has_method("assign_goal"):
			soldado.assign_goal(oGoalToAssign)
		get_parent().add_child.call_deferred(soldado)
		#add_child(soldado)

func assign_other_params(soldado):
	if soldado.has_method("set_guards") and "guards" in oOtherParams:
		soldado.set_guards(oOtherParams.guards.unit_type, oOtherParams.guards.quantity)
	return soldado
	
func get_possible_spawns():
	var aPossibleSpawns = []
	
	if aPossibleSpawns.size() == 0:
		aPossibleSpawns.push_back(global_position)
	
	return aPossibleSpawns
	
func _on_timer_de_spawn_unidades_timeout():
	if queue.size() > 0:
		var unitSceneCalled = queue.pop_front()
		spawn_unit(unitSceneCalled)
		#print("spawned from queue")
		#print(unitSceneCalled)
		#print(queue)
	else:
		spawn_new_call(probabilitySpawnOnTimer)

func in_queue(faction_param, unit_type_searched):
	var unitSceneSearched = "res://scenes/" + faction_param + "/" + unit_type_searched + ".tscn"
	return queue.count(unitSceneSearched)

func queue_size():
	return queue.size()

func queue_spawn_unit(faction_q, unit_type_called):
	var unitSceneCalled = "res://scenes/" + faction_q + "/" + unit_type_called + ".tscn"
	queue.push_back(unitSceneCalled)

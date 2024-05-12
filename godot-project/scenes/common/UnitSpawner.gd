extends Marker2D
var entity = null
@export var probabilitySpawnOnTimer = 20.0
@export var spawnOnReady = true
@export var unitScene = "res://scenes/patricios/granadero.tscn"
@export var faction = ""
@export var respawn_seconds = 2.5
@export var max_alive = 0
@export var controled_max_alive = false
var queue = []

var rng = RandomNumberGenerator.new()
var oGoalToAssign = null

func _ready():
	entity = load(unitScene)
	$TimerDeSpawnUnidades.start(respawn_seconds)
	if spawnOnReady:
		spawn_new_call(100.0)

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

func spawn_new_call(probability_generation):
	var value_creation = rng.randf_range(0.0, 100.0)
	var can_spawn = not controled_max_alive or max_alive >= get_tree().get_nodes_in_group("faccion_" + faction).size() + 1
	if can_spawn and not $SpawnArea.has_overlapping_bodies() and value_creation <= probability_generation:
		var soldado = entity.instantiate();
		soldado.global_position = global_position
		soldado.add_to_faction(faction)
		if soldado.has_method("assign_goal"):
			soldado.assign_goal(oGoalToAssign)
		get_parent().add_child(soldado)
		#add_child(soldado)
	
func _on_timer_de_spawn_unidades_timeout():
	if queue.size() > 0:
		var unitSceneCalled = queue.pop_front()
		spawn_unit(unitSceneCalled)
		print("spawned from queue")
		print(unitSceneCalled)
		print(queue)
	else:
		spawn_new_call(probabilitySpawnOnTimer)

func in_queue(faction, unit_type_searched):
	var unitSceneSearched = "res://scenes/" + faction + "/" + unit_type_searched + ".tscn"
	return queue.count(unitSceneSearched)

func queue_size():
	return queue.size()

func queue_spawn_unit(faction, unit_type_called):
	var unitSceneCalled = "res://scenes/" + faction + "/" + unit_type_called + ".tscn"
	queue.push_back(unitSceneCalled)

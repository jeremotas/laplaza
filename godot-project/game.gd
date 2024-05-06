extends Node2D

var new_position_order = null
var fDivisor = 1.0
var iSecondsPassed = 0
var TheGameStats : GameStats
var last_level = 0
@onready var HUD = $HUD

# Called when the node enters the scene tree for the first time.
func _ready():
	get_viewport().set_physics_object_picking_sort(true)
	$UnitSpawner.set_goal($General)
	$UnitSpawner2.set_goal($General)
	TheGameStats = GameStats.new()
	TheGameStats._ready()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	HUD.change(TheGameStats)
	if TheGameStats.level != last_level:
		$ChangeLevel.play()
		last_level = TheGameStats.level
	assign_max_alive()
	pass

func assign_max_alive():
	$UnitSpawner.max_alive = TheGameStats.level
	$UnitSpawner2.max_alive = TheGameStats.level

#func _on_clickable_area_clicked_position(position):
	# Tengo una nueva posicion para ir.
#	new_position_order = position
#	for unidad in get_tree().get_nodes_in_group("unidades_seleccionadas"):
#		unidad.get_parent().go_to(new_position_order)


func _on_scene_timer_timeout():
	fDivisor += 1.0
	var fMaxTime = 20.0
	$EnemySpawner.set_rewspan_seconds(fMaxTime / fDivisor)
	$EnemySpawner2.set_rewspan_seconds(fMaxTime / fDivisor)
	$EnemySpawner3.set_rewspan_seconds(fMaxTime / fDivisor)
	$EnemySpawner4.set_rewspan_seconds(fMaxTime / fDivisor)
	$EnemySpawner5.set_rewspan_seconds(fMaxTime / fDivisor)


func _on_timer_timeout():
	iSecondsPassed += 1
	HUD.change_time(iSecondsPassed)

func _on_death(faction):
	if faction != $General.faction:
		TheGameStats.add_experience(3)
		

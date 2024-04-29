extends Marker2D
var entity = null
@export var probabilitySpawnOnTimer = 20.0
@export var spawnOnReady = true
@export var unitScene = "res://player_soldado.tscn"
@export var faction = ""

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	entity = load(unitScene)
	if spawnOnReady:
		spawn_new_call(100.0)
	pass # Replace with function body.

func spawn_new_call(probability_generation):
	var value_creation = rng.randf_range(0.0, 100.0)
	if not $SpawnArea.has_overlapping_bodies() and value_creation <= probability_generation:
		var soldado = entity.instantiate();
		soldado.position = Vector2.ZERO
		soldado.add_to_faction(faction)
		add_child(soldado)
	
func _on_timer_de_spawn_unidades_timeout():
	spawn_new_call(probabilitySpawnOnTimer)

#extends Node2D
class_name GameStats
@export var experience = 0
@export var level = 0
@export var experience_next_level = 0
@export var life = 0
@export var max_life = 0
@export var plaza = 0
@export var max_plaza = 0
@export var ingleses = 0
@export var patricios = 0
@export var game_over = false
@export var game_win = false

# Called when the node enters the scene tree for the first time.
func _ready():
	level = 0
	experience = experience_to_level(0)
	experience_next_level = experience_to_level(1)
	pass # Replace with function body.

func get_level():
	return level

func set_level(level_value):
	level = level_value
	experience = experience_to_level(level)
	experience_next_level = experience_to_level(level + 1)
	
func experience_to_level(level_param):
	# Segun la progresion de Ale se parece a exp_req = 10 * level + level^2.5
	var value = int(floor(10 * (level_param) + pow(level_param, 2.5)))
	value = value - value % 10
	return value

func set_experience(experience_value):
	experience = experience_value
	calculate_level_growth()

func add_experience(experience_gain):
	experience += experience_gain
	calculate_level_growth()

func calculate_level_growth():
	if experience > experience_to_level(level+1):
		level +=1
		experience_next_level = experience_to_level(level + 1)

extends Node2D

var sStatus = ''
var rng = RandomNumberGenerator.new()
const MOVE_SIZE = 1
const JUMP_SIZE = 2
const textures = [
	preload("res://assets/created/rockers/rock1.png"),
	preload("res://assets/created/rockers/rock2.png"),
	preload("res://assets/created/rockers/rock3.png"),
	preload("res://assets/created/rockers/rock4.png"),
	preload("res://assets/created/rockers/rock5.png"),
	preload("res://assets/created/rockers/rock6.png"),
	preload("res://assets/created/rockers/rock7.png")
]

func _ready():
	var iTexture = rng.randi_range(0,13)
	$TextureRect.scale = Vector2(1, 1)
	if iTexture > 6:
		$TextureRect.scale = Vector2(-1, 1)
		iTexture = iTexture - 7
	$TextureRect.texture = textures[iTexture]
	
	

func _process(delta):
	if sStatus == '':
		mover_lateral()
	elif sStatus == 'Movio':
		saltar()
	elif sStatus == 'Salto':
		var iProx = rng.randi_range(1,3)
		if iProx == 1: sStatus = ''
		elif iProx == 2: sStatus = 'Movio'
		if iProx == 3: sStatus = 'Salto'
		
func mover_lateral():
	sStatus = '---'
	if rng.randi_range(0,1) > 0:
		#Muevo derecha
		global_position.x += MOVE_SIZE
	else:
		#Muevo izquierda
		global_position.x -= MOVE_SIZE
	await get_tree().create_timer(0.2).timeout
	sStatus = 'Movio'
	
func saltar():
	sStatus = '---'
	global_position.y += JUMP_SIZE
	await get_tree().create_timer(0.1).timeout
	global_position.y -= JUMP_SIZE
	await get_tree().create_timer(0.1).timeout
	sStatus = 'Salto'

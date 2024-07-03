extends Node2D
@onready var Escuadron = $EscuadronCarpinchos

# Called when the node enters the scene tree for the first time.
func _ready():
	var initAttack = Vector2.ZERO
	var endAttack = Vector2.ZERO
	initAttack.x = -400
	initAttack.y = Escuadron.global_position.y
	endAttack.x = 3000
	endAttack.y = Escuadron.global_position.y 
	
	Escuadron.startAttack(initAttack, endAttack)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

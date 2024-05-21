extends Node2D
var EscuadronHusaresInfernales = preload("res://scenes/patricios/escuadron_husares_infernales.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var E = EscuadronHusaresInfernales.instantiate()
	var positionAttack = Vector2.ZERO
	positionAttack.x = -200
	positionAttack.y = 300
	var endPosition = Vector2.ZERO
	endPosition.x = 2000
	endPosition.y = 100
	add_child(E)
	E.startAttack(positionAttack, endPosition)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

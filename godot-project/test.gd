extends Node2D
var new_position_order = null

# Called when the node enters the scene tree for the first time.
func _ready():
	get_viewport().set_physics_object_picking_sort(true)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_clickable_area_clicked_position(position):
	# Tengo una nueva posicion para ir.
	new_position_order = position
	for unidad in get_tree().get_nodes_in_group("unidades_seleccionadas"):
		unidad.get_parent().go_to(new_position_order)

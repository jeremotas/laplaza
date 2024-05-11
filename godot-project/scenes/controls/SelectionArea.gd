extends Area2D

signal selection_toggled(selection)

@export var exclusive = false
@export var selection_action = "Click"

var selected = false : set = set_selected, get = get_selected

func set_selected(selection):
	if selection:
		_make_exclusive()
		add_to_group("unidades_seleccionadas")
	else:
		remove_from_group("unidades_seleccionadas")
		
	selected = selection
	emit_signal("selection_toggled", selected)
	
func _make_exclusive():
	if not exclusive:
		return
	get_tree().call_group("unidades_seleccionadas", "set_selected", false)
	
func _input_event(viewport, event, shape_idx):
	if event.is_action_pressed(selection_action):
		get_tree().get_root().set_input_as_handled()
		set_selected(not selected)

func get_selected():
	return selected


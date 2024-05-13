extends Node2D
@export var NeededUnits = 4
@export var UnitsArrived = 0
@export var faction = ""

func _process(delta):
	$Status.text = str(UnitsArrived) + " / " + str(NeededUnits)
	$Status.show()
	
	var unitsForGoal = get_tree().get_nodes_in_group("faccion_" + faction)
	for unit in unitsForGoal:
		if not unit.status.moving:
			unit.go_to($Marker.global_position, true)

func set_needed_units(iValue):
	NeededUnits = iValue

func completed():
	return UnitsArrived >= NeededUnits

func _on_area_body_entered(body):
	if body.faction == faction and NeededUnits > UnitsArrived:
		UnitsArrived += 1
		body.destroy_character()

extends Node2D
@export var NeededUnits = 4
@export var UnitsArrived = 0
@export var faction = ""

var rigning = false

func _ready():
	pass

func _process(_delta):
	$MastilSprite.play("default")
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
	if "faction" in body and body.faction == faction and NeededUnits > UnitsArrived:
		UnitsArrived += 1
		body.destroy_character()


func _on_area_2d_body_entered(body):
	body.original_z_index = body.z_index
	body.z_index = 12
	


func _on_area_2d_body_exited(body):
	body.z_index = body.original_z_index


func ring_bell():
	if not rigning:
		rigning = true
		$Bell.play()
		await $Bell.finished
		rigning = false
	

func _on_warning_zone_body_entered(body):
	print("Ingleses entrando...")
	if not $VisibleOnScreenNotifier2D.is_on_screen():
		ring_bell()
	

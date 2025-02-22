extends Character

@onready var animation = $AnimatedSprite2D

var bullet = preload("res://scenes/common/bullet.tscn")

func _init():
	min_damage_given = Global.settings.patricios.granadero.min_damage_given
	max_damage_given = Global.settings.patricios.granadero.max_damage_given
	max_speed = Global.settings.patricios.granadero.max_speed
	#print(min_damage_given, max_damage_given, max_speed)
	init()
	
func _ready():
	super()

func assign_goal(oGoal):
	oGoalAssigned = oGoal
	
#func malon_sticked():
#	var bSticked = false
#	if $MalonArea:
#		if $MalonArea.has_overlapping_bodies() and $MalonArea.get_overlapping_bodies().size() > 1:
#			for unitInArea in $MalonArea.get_overlapping_bodies():
#				if ("faction" in unitInArea) and unitInArea.faction == faction:
#					bSticked = true
#					
#	input_accepted = false
#	if not bSticked and oGoalAssigned:
#		go_to(oGoalAssigned.global_position, true)
	#else:
	#	input_accepted = true
	
func _process(delta):
	malon_sticked()
	attack()
	super(delta)

func attack():
	if attack_objective:
		var b = bullet.instantiate() 
		b.position = $WeaponPoint.position
		b.direction = (attack_objective.global_position - $WeaponPoint.global_position).normalized()
		b.objective_faction = attack_objective.faction
		b.min_damage = min_damage_given
		b.max_damage = max_damage_given
		b.set_collision_mask_bullet(2)
		
		get_parent().get_parent().add_child(b)
		
		attack_objective = null
	pass	

# Funciones para poder seleccionarlo.
func show_selection():
	if selected:
		$AnimatedSprite2D.material.set_shader_parameter("width", 1.0)
	else:
		$AnimatedSprite2D.material.set_shader_parameter("width", 0.0)
		
#func _on_selection_area_selection_toggled(selection):
#	selected = selection
#	show_selection()

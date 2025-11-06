extends Character

@onready var animation = $AnimatedSprite2D


var lagrima = preload("res://scenes/common/lagrima.tscn") 
var escolta_ingles = preload("res://scenes/ingleses/ingles.tscn") 
var escolta_highlander = preload("res://scenes/ingleses/highlander.tscn") 
var escolta_greensoldier = preload("res://scenes/ingleses/green_soldier.tscn") 
const GUNSHOT = preload("res://assets/original/sounds/gunshot2.mp3")
var bullet = preload("res://scenes/common/bullet.tscn") 	
var iAttacksMade = 0
var aAttackAngles = [0.0]
var iAttacksInitialRotation = 0
var bShuffleAngles = true
var sAttackObjective = "destino"
var oEnemyToFollow = null
var sEntityEscort = 'ingles'
var iEscortQuantity = 4

func _init():
	unit_type = "ingles"
	
	max_speed = Global.settings.ingleses.flagger.max_speed
	life = Global.settings.ingleses.flagger.life
	min_damage_given = Global.settings.ingleses.flagger.attack.min_damage_given
	max_damage_given = Global.settings.ingleses.flagger.attack.max_damage_given
	experience_given = Global.settings.ingleses.flagger.experience_given
	bullet_speed = Global.settings.ingleses.flagger.attack.bullet.speed
	bullet_lifetime = Global.settings.ingleses.flagger.attack.bullet.duration
	coolDownAttackTime = Global.settings.ingleses.flagger.attack.cooldown
	iAttackProbability = Global.settings.ingleses.flagger.attack.probability
	bShuffleAngles = Global.settings.ingleses.flagger.attack.shuffle_angles
	aAttackAngles  = Global.settings.ingleses.flagger.attack.angles
	sAttackObjective = Global.settings.ingleses.flagger.attack.objective
	drop_reward = true
	init()
	
	
	
func set_guards(sEntityEscortVal, iEscortQuantityVal):
	sEntityEscort = sEntityEscortVal
	iEscortQuantity = iEscortQuantityVal
	
func get_escolta_instance():
	var escolta_t = null
	if sEntityEscort == "highlander":
		escolta_t = escolta_highlander.instantiate()
		#$AnimatedFlag.modulate = Color("#0000FFFF")
	elif sEntityEscort == "green_soldier":
		escolta_t = escolta_greensoldier.instantiate()
		#$AnimatedFlag.modulate = Color("#00FFFFFF")
	else:
		escolta_t = escolta_ingles.instantiate()
		#$AnimatedFlag.modulate = Color("#00FF00FF")
	
	return escolta_t
	
func _ready():
	set_enemy_to_follow()
	if bShuffleAngles:
		aAttackAngles.shuffle()
	var escolta_instance = get_escolta_instance()
	max_speed = escolta_instance.max_speed
	super()

func _process(delta):
	attack()
	super(delta)

	
func set_enemy_to_follow():
	var aEnemyToFollow = get_tree().get_nodes_in_group("general_group")
	if aEnemyToFollow.size() == 1:
		oEnemyToFollow = aEnemyToFollow[0]

func drop_the_reward(experience_given_value):
	drop_reward = false
	var l = lagrima.instantiate()
	l.experience_given = experience_given_value
	l.global_position = global_position
	get_parent().add_child(l)

func attack():
	hasToAttack = false


func guards_points(ancho: float, alto: float, cantidad: int, ang_inicial: float = 0.0, sentido_horario: bool = false) -> PackedVector2Array:
	var out := PackedVector2Array()
	if cantidad <= 0 or ancho <= 0.0 or alto <= 0.0:
		return out

	var centro := Vector2(ancho * 0.5, alto * 0.5)
	var r := 0.5 * sqrt(ancho * ancho + alto * alto) + 10.0
	var paso := TAU / float(cantidad)
	var dir := -1.0 if sentido_horario else 1.0

	for i in cantidad:
		var ang := ang_inicial + dir * paso * float(i)
		var p := centro + Vector2(cos(ang), sin(ang)) * r
		out.append(p)

	return out

func _on_timer_spawn_escorts_timeout() -> void:
	var aPositions = guards_points(34.0, 40.0, iEscortQuantity, 0, true)
	
	for i in range(0, aPositions.size()): # genera 4 balas
		var escolta_instance = get_escolta_instance()
		var oPos = aPositions[i]
		escolta_instance.global_position = global_position + oPos
		escolta_instance.speed = speed
		escolta_instance.add_to_faction(faction)
		if escolta_instance.has_method("assign_goal"):
			escolta_instance.assign_goal(oGoalAssigned)
		print("ahi va...")
		get_parent().add_child(escolta_instance)	

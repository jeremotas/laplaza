extends Character

@onready var animation = $AnimatedSprite2D
@export var iMaxEvaluationDistanceBodies = 15
var deathTime = 20.0
var canKill = true

func _ready():
	$CoolDownKillTimer.wait_time = coolDownAttackTime
	$DeathTimer.wait_time = deathTime
	$DeathTimer.start()
	var c = modulate
	c.a = 1.0
	modulate = c

func _init():
	invincible = true
	unit_type = "manuela_pedraza"
	min_damage_given = Global.settings.patricios.manuela_pedraza.attack.min_damage_given
	max_damage_given = Global.settings.patricios.manuela_pedraza.attack.max_damage_given
	max_speed = Global.settings.patricios.manuela_pedraza.max_speed
	life = Global.settings.patricios.manuela_pedraza.life
	coolDownAttackTime = Global.settings.patricios.manuela_pedraza.attack.cooldown
	deathTime = Global.settings.patricios.manuela_pedraza.death_time
	init()

func find_goal():
	var aBodies = $ObjetivosAtacablesArea.get_overlapping_bodies()
	if aBodies.size() > 0:
		if canKill:
			var fDistMenor = INF
			for unitInArea in aBodies:
				if ("faction" in unitInArea) and unitInArea.faction != faction and unitInArea.life > 0:
					if aBodies.size() < iMaxEvaluationDistanceBodies:
						var fDist = (global_position - unitInArea.global_position).length()
						if oGoalAssigned == null or fDist < fDistMenor:
							oGoalAssigned = unitInArea
							fDistMenor = fDist
					else:
						oGoalAssigned = unitInArea
						continue
	else:
		go_to(Vector2(global_position.x-20, global_position.y))

func assign_goal(oGoal):
	oGoalAssigned = oGoal
	
func _process(delta):
	attack()
	super(delta)

func attack():
	if oGoalAssigned != null:	
		#Debo caminar en direccion al objetivo
		go_to(oGoalAssigned.global_position, true)
	else:
		#Debo elegir un objetivo
		find_goal()


func _on_combat_area_body_entered(body: Node2D) -> void:
	if canKill:
		var enemy_nodes = get_tree().get_nodes_in_group("manuela_targets")
		for enemy in enemy_nodes:
			if enemy:
				enemy.remove_from_group("manuela_targets")	
				enemy.life = 0			
		
	if "faction" in body and body.faction == 'ingleses' and canKill and life > 0:
		body.life = 0 #Mata de una a los enemigos
		canKill = false
		oGoalAssigned = null
		body.remove_from_group("manuela_targets")	
		$CoolDownKillTimer.start()
	elif "faction" in body and body.faction == 'ingleses' and not canKill and life > 0:
		body.add_to_group("manuela_targets")

func _on_combat_area_body_exited(body: Node2D) -> void:
	if "faction" in body and body.faction == 'ingleses':
		body.remove_from_group("manuela_targets")	
	
func _on_cool_down_kill_timer_timeout() -> void:
	canKill = true

func _on_death_timer_timeout() -> void:
	canKill = false
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 1.0)
	await get_tree().create_timer(1.0).timeout
	invincible = false
	life = 0

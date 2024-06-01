extends Character

@onready var animation = $AnimatedSprite2D

var bullet = preload("res://scenes/common/bullet.tscn")
var barrilete_cosmico = false
var barrileteTimer = null
const GUNSHOT = preload("res://assets/original/sounds/gunshot2.mp3")

func _init():
	unit_type = "general"
	min_damage_given = Global.settings.patricios.general.min_damage_given
	max_damage_given = Global.settings.patricios.general.max_damage_given
	max_speed = Global.settings.patricios.general.max_speed
	life = Global.settings.patricios.general.life
	bullet_speed = Global.settings.patricios.general.bullet_speed
	coolDownAttackTime = Global.settings.patricios.general.cooldown_attack_time
	invincible = false
	init()
	
func _process(delta):
	last_direction_message()
	attack()
	super(delta)

func last_direction_message():
	get_tree().call_group("faccion_patricios", "set_last_general_direction", last_input)

func attack():
	if attack_objective:
		var b = bullet.instantiate()
		if has_node("WeaponPoint"):
			b.global_position = $WeaponPoint.global_position
			b.direction = (attack_objective.global_position - $WeaponPoint.global_position).normalized()
			b.objective_faction = attack_objective.faction
			b.min_damage = min_damage_given
			b.max_damage = max_damage_given
			b.speed = bullet_speed
			b.set_collision_mask(2)
			b.set_color(Color(1, 1, 1))
			if barrilete_cosmico:
				b.set_color(Color(1,1,1,0.01))
			
			get_parent().add_child(b)
			attack_sound(GUNSHOT)
		
		attack_objective = null
	pass	
	
func init_barrilete_cosmico():
	barrilete_cosmico = true
	Engine.time_scale = 0.2
	min_damage_given = Global.settings.patricios.general.barrilete_cosmico.min_damage_given
	max_damage_given = Global.settings.patricios.general.barrilete_cosmico.max_damage_given
	max_speed = Global.settings.patricios.general.barrilete_cosmico.max_speed
	
	bullet_speed = Global.settings.patricios.general.barrilete_cosmico.bullet_speed
	coolDownAttackTime = Global.settings.patricios.general.cooldown_attack_time
	invincible = true
	
	# Determino cuanto dura el barrilete cosmico
	barrileteTimer = Timer.new()
	add_child(barrileteTimer)
	barrileteTimer.autostart = true
	barrileteTimer.wait_time = Global.settings.patricios.general.barrilete_cosmico.duration
	barrileteTimer.one_shot = true
	barrileteTimer.timeout.connect(end_barrilete_cosmico)
	barrileteTimer.start()
	get_parent().stop_music()
	
	$UnStateItalianoMusic.play(83.4)
	pass
	
func end_barrilete_cosmico():
	min_damage_given = Global.settings.patricios.general.min_damage_given
	max_damage_given = Global.settings.patricios.general.max_damage_given
	max_speed = Global.settings.patricios.general.max_speed
	life = Global.settings.patricios.general.life
	bullet_speed = Global.settings.patricios.general.bullet_speed
	coolDownAttackTime = Global.settings.patricios.general.cooldown_attack_time
	invincible = false
	barrilete_cosmico = false
	$UnStateItalianoMusic.stop()
	get_parent().start_music()
	Engine.time_scale = 1
	pass
	
func walk():
	if not barrilete_cosmico:
		$WalkSound.volume_db = -1
	else:
		$WalkSound.volume_db = -100
	
func idle():
	$WalkSound.volume_db = -100

func hurt():
	$HurtSound.play()
	modulate = Color("ff0000CC")
	await get_tree().create_timer(0.4).timeout
	modulate = Color("ffffffff")
	status.hurt = false

# Funciones para poder seleccionarlo.
func show_selection():
	if selected:
		$AnimatedSprite2D.material.set_shader_parameter("width", 1.0)
	else:
		$AnimatedSprite2D.material.set_shader_parameter("width", 0.0)
		
#func _on_selection_area_selection_toggled(selection):
#	selected = selection
#	show_selection()

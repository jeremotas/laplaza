extends CharacterBody2D

var original_z_index = 1
var life = 0
var max_life = 0
var faction = "patricios"
var invincible = false
var rng 
const CADENASSTINGER = preload("res://assets/created/sounds/cadenas/cadenas.mp3")


func _init():
	rng = RandomNumberGenerator.new()

func _ready():
	max_life = Global.settings.patricios.defensa_de_obligado.life
	life = max_life
	$CollisionShape2D.disabled = true
	$AnimatedSprite2D.hide()
	$AnimatedSprite2D.stop()
	
func process():
	print(life)
	

func armar():
	life = max_life
	set_collision_layer_value(3, true)
	set_collision_layer_value(2, true)
	set_collision_layer_value(1, true)
	$AnimatedSprite2D.show()
	$AnimatedSprite2D.play("aparecer")
	$CollisionShape2D.disabled = false
	var stream = CADENASSTINGER
	AudioStreamManager.play({"stream": stream, "volume": null, "pitch": null})
	#sonido de cadenas pendiente.

func desarmar():
	set_collision_layer_value(3, false)
	set_collision_layer_value(2, false)
	set_collision_layer_value(1, false)
	$CollisionShape2D.disabled = true
	$AnimatedSprite2D.hide()
	$AnimatedSprite2D.stop()
	
func hurt():
	$AnimatedSprite2D.play("hurt")
	await get_tree().create_timer(0.25).timeout
	$AnimatedSprite2D.animation = "aparecer"
	$AnimatedSprite2D.frame = 17

func TakeDamage(min_damage, max_damage):
	var damage = rng.randi_range(min_damage, max_damage)
	if damage > 0:
		life = life - damage 
		if life < 0: life = 0	
		hurt()
	if life <= 0:
		desarmar()

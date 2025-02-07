extends CanvasLayer
var oCarta = preload("res://scenes/controls/carta.tscn") 	
var rng = RandomNumberGenerator.new()

@export var card_offset_x: float = -10.0
@export var rot_max: float = 10.0
@export var anim_offset_y: float = 0.3
@export var time_multiplier: float = 2.0

var aCards : Array
var tween: Tween
var tween_animate: Tween

var sine_offset_mult: float = 0.0
var time: float = 0.0
var drawn: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$MarginContainer/HBoxContainer/GranaderoButtonCard.grab_focus()
	rot_max = deg_to_rad(rot_max)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	for i in range(aCards.size()):
		var c: TextureButton = aCards[i]
		var val: float = sin(i + (time * time_multiplier))
		#print("Child %d, sin(%d) = %f" % [i, i, val])
		c.position.y += val * sine_offset_mult


func prepare_hand(number: int) -> void:
	await get_tree().create_timer(2.0).timeout
	drawn = true
	if tween and tween.is_running():
		tween.kill()
	tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	aCards.clear()
	for i in range(number):
		var instance: TextureButton = oCarta.instantiate()
		add_child(instance)
		instance.global_position = $PosicionMaso.global_position
		aCards.push_back(instance)
		# -(instance.size / 2.0) to center the card
		#var final_pos: Vector2 = -(instance.size / 2.0) - Vector2(card_offset_x * (number - 1 - i), 0.0)
		# offset to the right everything has we are going to place cards to the left
		#final_pos.x += ((card_offset_x * (number-1)) / 2.0)
		var final_pos = $PosicionMano.global_position
		var ancho_total = (instance.size.x - card_offset_x) * number
		final_pos.x += -ancho_total / 2.0 + (i * (instance.size.x + card_offset_x)) - card_offset_x
		print(final_pos)
		#print("Offset: ", float(i)/float(number-1))
		var rot_radians: float = lerp_angle(-rot_max, rot_max, float(i)/float(number-1))
		#print("Rot: ", rot_radians)
		#print("Card %d: , size: %s, pivot: %s" % [i, str(instance.size), str(instance.pivot_offset)])
		
		# Animate pos
		tween.parallel().tween_property(instance, "position", final_pos, 0.5 + (i * 0.075))
		tween.parallel().tween_property(instance, "rotation", rot_radians, 0.5 + (i * 0.075))
	
	tween.tween_callback(set_process.bind(true))
	tween.tween_property(self, "sine_offset_mult", anim_offset_y, 1.5).from(0.0)
	animate_cards()

func animate_cards() -> void:
	if tween_animate and tween_animate.is_running():
		tween_animate.kill()
	tween_animate = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween_animate.set_loops()
	for i in range(aCards.size()):
		var c: TextureButton = aCards[i]
	
func prepare_buttons(_experience):
	$MarginContainer/HBoxContainer/GranaderoButtonCard.visible = false
	$MarginContainer/HBoxContainer/MorenoButtonCard.visible = false
	$MarginContainer/HBoxContainer/CorrentinoButtonCard.visible = false
	$MarginContainer/HBoxContainer/ArribenoButtonCard.visible = false
	$MarginContainer/HBoxContainer/MoreLifeButtonCard.visible = false
	$MarginContainer/HBoxContainer/HusaresInfernalesButtonCard.visible = false
	$MarginContainer/HBoxContainer/BarrileteCosmicoButtonCard.visible = false
	$MarginContainer/HBoxContainer/LasOllasButtonCard.visible = false
	
	# Preparo arreglo con distribucion (unidades y efectos)
	# "granadero", "correntino", "moreno", "arribeno"
	# "upgrade_life", "barrilete_cosmico", "ataque_husares_infernales"
	var aButtonsUnidades = []
	for i in range(Global.settings.game.cards.granadero): aButtonsUnidades.push_back($MarginContainer/HBoxContainer/GranaderoButtonCard)
	for i in range(Global.settings.game.cards.correntino): aButtonsUnidades.push_back($MarginContainer/HBoxContainer/CorrentinoButtonCard)
	for i in range(Global.settings.game.cards.moreno): aButtonsUnidades.push_back($MarginContainer/HBoxContainer/MorenoButtonCard)
	for i in range(Global.settings.game.cards.arribeno): aButtonsUnidades.push_back($MarginContainer/HBoxContainer/ArribenoButtonCard)
	
	var aButtonsEfectos = []
	#for i in range(Global.settings.game.cards.matecito): aButtonsEfectos.push_back($MarginContainer/HBoxContainer/MoreLifeButtonCard)
	for i in range(Global.settings.game.cards.husares_infernales): aButtonsEfectos.push_back($MarginContainer/HBoxContainer/HusaresInfernalesButtonCard)
	for i in range(Global.settings.game.cards.barrilete_cosmico): aButtonsEfectos.push_back($MarginContainer/HBoxContainer/BarrileteCosmicoButtonCard)
	for i in range(Global.settings.game.cards.ollas_del_pueblo): aButtonsEfectos.push_back($MarginContainer/HBoxContainer/LasOllasButtonCard)
	
	
	
	aButtonsUnidades.shuffle()
	aButtonsEfectos.shuffle()
	
	var oCard1 = aButtonsUnidades[0]
	oCard1.visible = true
	var aNewButtons = []
	for i in range (aButtonsUnidades.size()):
		if aButtonsUnidades[i] != oCard1:
			aNewButtons.push_back(aButtonsUnidades[i])
	
	aNewButtons[0].visible = true
	aButtonsEfectos[0].visible = true
	$MarginContainer/HBoxContainer/MoreLifeButtonCard.visible = true
	
	
	oCard1.grab_focus.call_deferred()
	pass


#func _on_granadero_button_pressed():
#	get_parent().decision_time_end("granadero")


#func _on_correntino_button_pressed():
#	get_parent().decision_time_end("correntino")


#func _on_more_life_button_pressed():
#	get_parent().decision_time_end("upgrade_life")


func _on_visibility_changed():
	if visible:
		$MarginContainer/HBoxContainer/GranaderoButtonCard.grab_focus()

func _on_granadero_button_card_pressed():
	get_parent().decision_time_end("granadero")
	


func _on_correntino_button_card_pressed():
	get_parent().decision_time_end("correntino")


func _on_moreno_button_card_pressed():
	get_parent().decision_time_end("moreno")


func _on_more_life_button_card_pressed():
	get_parent().decision_time_end("upgrade_life")


func _on_barrilete_cosmico_button_card_pressed():
	get_parent().decision_time_end("barrilete_cosmico")	


func _on_husares_infernales_button_card_pressed():
	get_parent().decision_time_end("ataque_husares_infernales")


func _on_arribeno_button_card_pressed():
	get_parent().decision_time_end("arribeno")


func _on_las_ollas_button_card_pressed():
	get_parent().decision_time_end("ollas_del_pueblo")
	

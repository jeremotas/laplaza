extends CanvasLayer
var oCarta = preload("res://scenes/controls/carta.tscn")
var rng = RandomNumberGenerator.new()

@export var card_offset_x: float = -95.0
@export var rot_max_t: float = 5.0
@export var rot_max: float
@export var anim_offset_y: float = 0.1
@export var time_multiplier: float = 1.0
@export var fWaitHandTime : float = 0.25
@export var fScaleSelected : float = 1.25

var sDecisionTomada
var iDecisionTomadaPosicion 

var aCards : Array
var tween: Tween
var tween_animate: Tween
var tween_mazo: Tween

var sine_offset_mult: float = 0.2
var time: float = 0.0
var drawn: bool = false
var iActualPosition = 0
var can_get_input = true
#var ready_for_input: bool = false

@onready var contenedor_cartas = $CartasContainer

func init():
	#tween.custom_step(0.1)
	#tween_animate.custom_step(0.1)
	pass

func _ready():
	rot_max = deg_to_rad(rot_max_t)
	get_tree().paused = true
	contenedor_cartas.global_position = $Control/PosicionMano.global_position
	card_offset_x = (100 - 500 / Global.mazo.size()) * -1
	draw_hand()
	$Control/Label.text = str(aCards.size()) + " cartas"

func _process(delta):
	pass
	# Animacion de cartas
	#animate_cards_calculation(delta)
	
func _input(event):
	if contenedor_cartas.ready_for_input:
		if Input.is_action_just_pressed('ui_left'):
			handle_input('left', true)
		elif Input.is_action_just_pressed('ui_right'):
			handle_input('right', true)
		elif Input.is_action_pressed('ui_left'):
			handle_input('left', false)
		elif Input.is_action_pressed('ui_right'):
			handle_input('right', false)
	
	if Input.is_action_just_pressed("pause"):
		volver_al_menu()

func volver_al_menu():
	Global.mazo.rearmar()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/screens/inicio.tscn")

func handle_input(direction_pressed, set_can_get_input):
	if visible == true:
		can_get_input = set_can_get_input
		var iOldPosition = iActualPosition
		
		if direction_pressed == 'right' and aCards.size()-1 > iActualPosition:
			iActualPosition += 1
		if direction_pressed == 'left' and 0 < iActualPosition:
			iActualPosition += -1
		if iOldPosition != iActualPosition:
			aCards[iActualPosition].grab_focus()
		print(iActualPosition)
			

func correr_mazo(i):
	var aCartas = contenedor_cartas.get_children()
	for oCard in aCartas:
		oCard.global_position.x += 150 * i - card_offset_x
		
func animate_cards_calculation(delta):
	if drawn:
		time += delta
		for i in range(aCards.size()):
			var c: TextureButton = aCards[i]
			var val: float = sin(i + (time * time_multiplier))
			c.position.y += val * sine_offset_mult
		
func draw_hand() -> void:
	iActualPosition = 0
	var number = Global.mazo.size()
	#await get_tree().create_timer(fWaitHandTime).timeout
	drawn = true
	if tween and tween.is_running():
		tween.kill()
	tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	aCards.clear()
	
	var aMano = get_mano(number)
	
	for i in range(number-1, -1, -1):
		var oCardInstance: TextureButton = oCarta.instantiate()
		oCardInstance.prepare(aMano[i])
		contenedor_cartas.add_child(oCardInstance)
		oCardInstance.global_position = $Control/PosicionMazo.global_position
		oCardInstance.set_move_on_selection(120)
		aCards.push_front(oCardInstance)
		var final_pos = $Control/PosicionMano.global_position
		#print(final_pos)
		var ancho_total = (oCardInstance.size.x + card_offset_x) * number
		final_pos.x += -ancho_total / 2 + (i * (oCardInstance.size.x + card_offset_x)) + card_offset_x / 2
		#final_pos.x += (i * (oCardInstance.size.x + card_offset_x)) - oCardInstance.size.x / 2
		#print(final_pos.x,  ' ', ancho_total)
		var rot_radians: float = lerp_angle(-rot_max, rot_max, float(i)/float(number-1))
		#var rot_radians = 0.0
		# Animate pos
		tween.parallel().tween_property(oCardInstance, "global_position", final_pos, 0.15 + (i * 0.05))
		#tween.parallel().tween_property(oCardInstance, "rotation", rot_radians, 0.5 + (i * 0.05))
		
	
	
	tween.tween_callback(set_process.bind(true))
	tween.tween_property(self, "sine_offset_mult", anim_offset_y, 0.15).from(0.0)
	
	#animate_cards()
	#await get_tree().create_timer(1.0).timeout
	
	for i in range(number):
		#print(get_path_to(aCards[i+1]))
		if i > 0:
			aCards[i].focus_neighbor_left = get_path_to(aCards[i-1])
		if i < number - 1:
			aCards[i].focus_neighbor_right = get_path_to(aCards[i+1])
		
	contenedor_cartas.ready_for_input = true
	
	for i in range(number):
		aCards[i].card_flip(i*0.03 + 0.25)
	await tween.finished
	aCards[0].grab_focus()
	
func undraw_cards(iSelectedCard) -> void:
	var child_count = aCards.size()
	var cSelected = aCards[iSelectedCard]
	var to_pos = $Control/PosicionMazo.global_position
	var to_pos_center = $Control/PosicionMano.global_position + Vector2(cSelected.size.x + 320, 0) 
	drawn = false
	if tween and tween.is_running():
		tween.kill()
	tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "sine_offset_mult", 0.0, 0.1)
	
	for i in range(child_count-1, -1, -1):
		var c: TextureButton = aCards[i]
		aCards[i].card_flip(0.25)
		if iSelectedCard != i:
			# Animate pos
			tween.parallel().tween_property(c, "global_position", to_pos, 0.15 + ((child_count - i) * 0.075)).set_delay(0.75)
			tween.parallel().tween_property(c, "rotation", 0.0, 0.15 + ((child_count - i) * 0.075)).set_delay(0.75)
		else:
			tween.parallel().tween_property(cSelected, "global_position", to_pos_center, 0.3)
			tween.parallel().tween_property(cSelected, "rotation", 0.0, 0.3)
			$Control/Leyenda.text = ""
	
	await tween.finished
	#tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	#tween.parallel().tween_property(cSelected, "global_position", to_pos, 0.3)
	#tween.parallel().tween_property(cSelected, "rotation", 0.0, 0.3)
	#tween.parallel().tween_property(cSelected, "scale", Vector2(1, 1), 0.3)
	
	#await tween.finished
		
	for i in range(child_count-1, -1, -1):
		var c: TextureButton = aCards[i]
		c.queue_free()
	
func get_mano(iCantidadCartas):
	var aMano = []
	for i in range(iCantidadCartas):
		var oCartaInfo = get_una_carta_mazo()
		oCartaInfo.posicion_en_mano = i
		aMano.push_back(oCartaInfo)
		
	return aMano

func get_una_carta_mazo():
	var oCartaMazo = Global.mazo.tomar_carta()
	return oCartaMazo
	
func animate_cards() -> void:
	if tween_animate and tween_animate.is_running():
		tween_animate.kill()
	tween_animate = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween_animate.set_loops()
	for i in range(aCards.size()):
		var c: TextureButton = aCards[i]

func change_leyenda(sLeyenda):
	$Control/Leyenda.text = sLeyenda

func _on_visibility_changed():
	if visible:
		contenedor_cartas.ready_for_input = false
		tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
		tween.tween_property($Control, "modulate:a", 1, 0.5)
		await tween.finished
		draw_hand()
		$Control/Label.text = str(aCards.size()) + " cartas"
		
func decision_elegida(sDecisionTomadaCarta, iPosicion):
	if aCards.size() < 20:
		$AcceptDialog.popup_centered()
		$AcceptDialog.show()
		$AcceptDialog.grab_focus() 
	else:
		sDecisionTomada = sDecisionTomadaCarta
		iDecisionTomadaPosicion = iPosicion
		$ConfirmationDialog.popup_centered()
		$ConfirmationDialog.show()
		$ConfirmationDialog.grab_focus() 
	
func _on_timer_timeout():
	can_get_input = true

func _on_confirmation_dialog_canceled():
	pass # Replace with function body.

func _on_confirmation_dialog_confirmed():
	
	#contenedor_cartas.ready_for_input = false
	destroy_selected_card()
	
func destroy_selected_card():
	var aCardsMazo = Global.save_data.original_cards
	for i in range(aCardsMazo.size()):
		if aCardsMazo[i].name == sDecisionTomada:
			aCardsMazo[i].quantity -= 1
			
	Global.save_data.original_cards = aCardsMazo
	Global.save_data.save()	
	await undraw_cards(iDecisionTomadaPosicion)
	Global.mazo = Mazo.crear(aCardsMazo)
	draw_hand()
	$Control/Label.text = str(aCards.size()) + " cartas"
	
	
	

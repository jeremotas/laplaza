extends CanvasLayer
var oCarta = preload("res://scenes/controls/carta.tscn")
#var oMazoClass = preload("res://scenes/controls/carta.tscn")
@onready var contenedor_cartas = $ContenedorCartas
var rng = RandomNumberGenerator.new()
var card_offset_x = 10.0
var tween : Tween
var oMazo 
var oLastCardSelected
var sSobreType = "azul"

func _init():
	pass
	

# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.save_data.sobres_pendientes.azul > 0:
		Global.save_data.sobres_pendientes.azul = Global.save_data.sobres_pendientes.azul - 1
		sSobreType = "azul"
	elif Global.save_data.sobres_pendientes.verde > 0:
		Global.save_data.sobres_pendientes.verde = Global.save_data.sobres_pendientes.verde - 1
		sSobreType = "verde"
	elif Global.save_data.sobres_pendientes.rojo > 0:
		Global.save_data.sobres_pendientes.rojo = Global.save_data.sobres_pendientes.rojo - 1
		sSobreType = "rojo"
	Global.save_data.save()	
	$Sobre.type(sSobreType)
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "up":
		$Sobre.start_particles()
		$Sobre.grab_focus()
	if anim_name == "to_white":
		$Sobre.hide()
		$AnimationPlayer.play("to_transparent")
		
		cards_roulette(sSobreType)
		
func create_mano(sSobreType):
	var aOriginalCards = []
	if sSobreType == 'azul':
		aOriginalCards = Global.settings.sobres.azul
	if sSobreType == 'rojo':
		aOriginalCards = Global.settings.sobres.rojo
	if sSobreType == 'verde':
		aOriginalCards = Global.settings.sobres.verde
	oMazo = Mazo.crear(aOriginalCards)
	oMazo.mezclar()
	return oMazo.aCards
		
func cards_roulette(sSobreType):
	var aMano = create_mano(sSobreType)
	var number = aMano.size()
	
	if tween and tween.is_running():
		tween.kill()
	tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	#tween = create_tween().set_trans(Tween.TRANS_LINEAR)
	#number = 50
	var iCartaSeleccionada = number / 4 + rng.randi_range(0, number / 4) * 2
	for i in range(number):
		var oCardInstance: TextureButton = oCarta.instantiate()
		oCardInstance.prepare(aMano[i])
		oCardInstance.card_flip()
		contenedor_cartas.add_child(oCardInstance)
	$Selector.show()
	var final_pos = $DestinoCartas.global_position
	final_pos.x = final_pos.x - iCartaSeleccionada * 100
	contenedor_cartas.global_position = $OrigenCartas.global_position
	tween.tween_property(contenedor_cartas, "global_position", final_pos, 0.15 * iCartaSeleccionada)
	await tween.finished
	$Selector.hide()
	tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	for oCard in contenedor_cartas.get_children():
		#print(oCard, ' ', oLastCardSelected, oCard != oLastCardSelected)
		if oCard != oLastCardSelected:
			tween.parallel().tween_property(oCard, "modulate", Color("ffffff", 0.0), 0.5)
		else:
			var fScale = 2
			tween.parallel().tween_property(oCard, "global_position", Vector2(640 / 2 - 100 / 2, 480 / 2 - 136 / 2 - 60), 0.5)
			tween.parallel().tween_property(oCard, "scale", Vector2(fScale, fScale), 0.5)
	await tween.finished
	
	$Opciones.show()
	$Opciones/Agregar.grab_focus()


func _on_sobre_pressed():
	$AnimationPlayer.play("to_white")


func _on_init_timeout():
	$AnimationPlayer.play("up")

func _on_area_2d_body_entered(body):
	oLastCardSelected = body.get_parent()
	$Tick.play()

func _on_descartar_pressed():
	get_tree().change_scene_to_file("res://scenes/screens/inicio.tscn")

func _on_agregar_pressed():
	agregar_carta_a_mazo()
	get_tree().change_scene_to_file("res://scenes/screens/inicio.tscn")

func agregar_carta_a_mazo():
	for i in range(Global.save_data.original_cards.size()):
		if oLastCardSelected.sDecisionTimeMessage == Global.save_data.original_cards[i].name:
			Global.save_data.original_cards[i].quantity += 1
	Global.save_data.save()
	Global.mazo = Mazo.crear(Global.save_data.original_cards)

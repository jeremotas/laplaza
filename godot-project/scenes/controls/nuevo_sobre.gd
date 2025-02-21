extends CanvasLayer
var oCarta = preload("res://scenes/controls/carta.tscn")
#var oMazoClass = preload("res://scenes/controls/carta.tscn")
@onready var contenedor_cartas = $ContenedorCartas
var rng = RandomNumberGenerator.new()
var card_offset_x = 10.0
var tween : Tween
var oMazo 
var oLastCardSelected

# Called when the node enters the scene tree for the first time.
func _ready():
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
		cards_roulette("azul")
		
func create_mano(sSobreType):
	var aOriginalCards = []
	if sSobreType == 'azul':
		aOriginalCards = Global.settings.sobres.azul
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
	var iCartaSeleccionada = 15
	for i in range(number):
		var oCardInstance: TextureButton = oCarta.instantiate()
		oCardInstance.prepare(aMano[i])
		oCardInstance.card_flip()
		contenedor_cartas.add_child(oCardInstance)
	$Selector.show()
	var final_pos = $DestinoCartas.global_position
	final_pos.x = final_pos.x - iCartaSeleccionada * 100
	contenedor_cartas.global_position = $OrigenCartas.global_position
	tween.tween_property(contenedor_cartas, "global_position", final_pos, 10.0)
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

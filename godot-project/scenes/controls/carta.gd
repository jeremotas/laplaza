extends TextureButton

var sTipo = ""
var sDecisionTimeMessage = ""
var iCantidad = 0
var sImagenPrincipal = ""
var iPosicionEnMano = 0
var sTitulo = ""
var sLetra = ""
var sLetraInvertida = ""
var sLetraColor = ""
var sLeyenda = ""
var iMoveOnSelection = 15
@onready var oTitulo = $Titulo
@onready var letra = $Letra
@onready var letra_invertida = $LetraInvertida
var original_position = null

const rsSonidoCarta = preload("res://assets/created/cartas/resaltarcarta.wav")

const rsNormalTextureUnidad = preload("res://assets/created/cartas/carta_unidad.png")
const rsNormalTextureEvento = preload("res://assets/created/cartas/carta_evento.png")
const rsNormalTextureTruco = preload("res://assets/created/cartas/carta_truco.png")

#const rsSelectedTextureEvento = preload("res://assets/created/carta_evento_frente_focus.png")
#const rsSelectedTextureUnidad = preload("res://assets/created/carta_unidad_frente_focus.png")
#const rsSelectedTextureTruco = preload("res://assets/created/carta_truco_frente_focus.png")

const rsSelectedTextureUnidad = preload("res://assets/created/cartas/carta_unidad.png")
const rsSelectedTextureEvento = preload("res://assets/created/cartas/carta_evento.png")
const rsSelectedTextureTruco = preload("res://assets/created/cartas/carta_truco.png")

const aImagenes = {
	"granadero": preload("res://assets/created/cartas/imagen/patricio_retrato_32.png"),
	"moreno": preload("res://assets/created/cartas/imagen/moreno_retrato_32.png"),
	"correntino": preload("res://assets/created/cartas/imagen/correntino_retrato_32.png"),
	"arribeno": preload("res://assets/created/cartas/imagen/arribeno_retrato_32.png"),
	"barrilete_cosmico": preload("res://assets/created/cartas/imagen/barrilete_retrato_32.png"),
	"ataque_husares_infernales": preload("res://assets/created/cartas/imagen/huspueynegro_retrato_64A.png"),
	"upgrade_life": preload("res://assets/created/cartas/imagen/mate_retrato_32.png"),
	"ollas_del_pueblo": preload("res://assets/created/cartas/imagen/olla_retrato_32.png"),
	"cebador": preload("res://assets/created/cartas/imagen/cebador_retrato_32.png"),
	"manuela_pedraza": preload("res://assets/created/cartas/imagen/manuela_pedraza_retrato_32.png"),
	"sudestada": preload("res://assets/created/cartas/imagen/sudestada_retrato_32.png"),
}

var tween: Tween
#res://assets/created/carta_frente.png

func init():
	#tween.custom_step(0.1)
	pass

func _ready():
	global_position.x = 640 - 84
	global_position.y = 480
	$Titulo.text = sTitulo
	$Letra.text = sLetra
	$LetraInvertida.text = sLetraInvertida
	#$Letra.modulate = sLetraColor
	#$LetraInvertida.modulate = sLetraColor

func _process(_delta):
	#print(global_position)
	pass

func prepare(oCartaValues):
	sTipo = oCartaValues.tipo
	sDecisionTimeMessage = oCartaValues.decision_time_message
	iCantidad = oCartaValues.cantidad
	sTitulo = oCartaValues.titulo
	iPosicionEnMano = oCartaValues.posicion_en_mano
	sLeyenda = oCartaValues.leyenda
	# Preparo texturas del boton
	prepare_textures()
	# Preparo los textos
	sLetra = oCartaValues.numero
	sLetraInvertida = oCartaValues.numero

func prepare_textures():
	if sTipo == "unidad":
		texture_normal = rsNormalTextureUnidad
		texture_hover = rsSelectedTextureUnidad
		texture_focused = rsSelectedTextureUnidad
		sLetra = "1"
		sLetraInvertida = "1"
		#sLetraColor = "#298DF8"
	elif sTipo == "evento":
		texture_normal = rsNormalTextureEvento
		texture_hover = rsSelectedTextureEvento
		texture_focused = rsSelectedTextureEvento	
		sLetra = "1"
		sLetraInvertida = "1"
	elif sTipo == "truco":
		texture_normal = rsNormalTextureTruco
		texture_hover = rsSelectedTextureTruco
		texture_focused = rsSelectedTextureTruco
		sLetra = "1"
		sLetraInvertida = "1"
		
	if aImagenes[sDecisionTimeMessage]:
		$Frente.texture = aImagenes[sDecisionTimeMessage]
	pass

func set_move_on_selection(iValue):
	iMoveOnSelection = iValue

func _on_pressed():
	#print("Mensaje", iPosicionEnMano, sDecisionTimeMessage)
	get_parent().decision_elegida(sDecisionTimeMessage, iPosicionEnMano)


func _on_focus_entered():
	card_up()
	var sLeyendaT = sLeyenda.replace(" __ ", "\n")
	get_parent().change_leyenda(sLeyendaT)
	

func _on_focus_exited():
	card_down()

func _on_mouse_entered():
	#card_up()
	pass

func _on_mouse_exited():
	#card_down()
	pass

func card_up():
	if not get_parent().ready_for_input:
		return
	if original_position == null:
		original_position = global_position
	if tween and tween.is_running():
		tween.kill()
	tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	var final_pos = original_position
	final_pos.y += -iMoveOnSelection
	tween.parallel().tween_property(self, "global_position", final_pos, 0.25)
	AudioStreamManager.play({"stream": rsSonidoCarta, "volume": null, "pitch": null})
	#global_position.y = original_position.y - iMoveOnSelection
	
	
func card_down():
	if not get_parent().ready_for_input:
		return
	if original_position == null:
		original_position = global_position
	if tween and tween.is_running():
		tween.kill()
	tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	var final_pos = original_position
	tween.parallel().tween_property(self, "global_position", final_pos, 0.25)
	#global_position.y = original_position.y
	
func card_flip(fSec = 0.0):
	if fSec > 0.0:
		await get_tree().create_timer(fSec).timeout
	if $Back.visible:
		$AnimationPlayer.play("card_flip")
	else:
		$AnimationPlayer.play_backwards("card_flip")
	AudioStreamManager.play({"stream": rsSonidoCarta, "volume": null, "pitch": null})

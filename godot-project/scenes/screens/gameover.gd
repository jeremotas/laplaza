extends Node
var tween : Tween

func _ready():
	if name == 'Victoria':
		dar_recompensa_sobre("rojo")
	elif Global.save_data.lagrimas_ultima_run > 1200:
		dar_recompensa_sobre("verde")
	elif Global.save_data.lagrimas_ultima_run > 100:
		dar_recompensa_sobre("azul")
		
	$MarginContainer2/VBoxContainer/Panel/Reiniciar.grab_focus()
	if $Personajes/General:
		$Personajes/General.celebration()
		
	var aButtons = [
		$MarginContainer2/VBoxContainer/Panel/Reiniciar,
		$MarginContainer2/VBoxContainer/Panel/Salir
	]
	Global.prepare_buttons_menu(aButtons)

func _on_reiniciar_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/" + Global.settings.game.init_level + ".tscn")

func _on_salir_pressed():
	get_tree().change_scene_to_file("res://scenes/screens/inicio.tscn")

func _on_wishlist_pressed():
	OS.shell_open("http://laromero.com.ar/wishlist/")


func _on_steam_pressed():
	OS.shell_open("http://laromero.com.ar/wishlist/")
	pass # Replace with function body.

func dar_recompensa_sobre(sSobreType):
	if sSobreType == "azul":
		Global.save_data.sobres_pendientes.azul +=1
	if sSobreType == "verde":
		Global.save_data.sobres_pendientes.verde +=1	
	if sSobreType == "rojo":
		Global.save_data.sobres_pendientes.rojo +=1
		
	show_sobrecito(sSobreType)
		
	Global.save_data.save()

func show_sobrecito(sSobreType):
	$ContenedorSobre/Sobre.type(sSobreType)
	if tween and tween.is_running():
		tween.kill()
	tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	
	var original_pos = $ContenedorSobre.global_position
	var final_pos = $ContenedorSobre.global_position
	final_pos.x -= 180
	
	
	tween.tween_property($ContenedorSobre, "global_position", final_pos, 1.5).set_delay(1.0)
	await tween.finished
	tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property($ContenedorSobre, "global_position", original_pos, 1.5).set_delay(2.0)
	await tween.finished

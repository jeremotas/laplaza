extends CanvasLayer

var MejorasData = null
var lagrimas_acumuladas = 0

func _ready():
	MejorasData = Global.settings.game.mejoras
	load_prices()
	load_saved_values()
	calculate_saldo_lagrimas()
	
	$MarginContainer/VBoxContainer2/Menu.grab_focus()

func load_saved_values():
	lagrimas_acumuladas = Global.save_data.lagrimas_acumuladas
	$MarginContainer/Mejoras/ArribenoCantidad.value = Global.save_data.mejoras.arribenos
	$MarginContainer/Mejoras/CorrentinoCantidad.value = Global.save_data.mejoras.correntinos
	$MarginContainer/Mejoras/GranaderoCantidad.value = Global.save_data.mejoras.granaderos
	$MarginContainer/Mejoras/MorenoCantidad.value = Global.save_data.mejoras.morenos

func load_prices():
	
	$MarginContainer/Mejoras/ArribenoValor.text = str(MejorasData.arribeno.valor)
	$MarginContainer/Mejoras/CorrentinoValor.text = str(MejorasData.correntino.valor)
	$MarginContainer/Mejoras/GranaderoValor.text = str(MejorasData.granadero.valor)
	$MarginContainer/Mejoras/MorenoValor.text = str(MejorasData.moreno.valor)
	
	$MarginContainer/Mejoras/ArribenoCantidad.max_value = MejorasData.arribeno.maxima_cantidad
	$MarginContainer/Mejoras/CorrentinoCantidad.max_value = MejorasData.correntino.maxima_cantidad
	$MarginContainer/Mejoras/GranaderoCantidad.max_value = MejorasData.granadero.maxima_cantidad
	$MarginContainer/Mejoras/MorenoCantidad.max_value = MejorasData.moreno.maxima_cantidad

func _process(_delta):
	calculate_saldo_lagrimas()
	pass

func calculate_saldo_lagrimas():
	var gastado = calculate_gastado()
	var saldo = lagrimas_acumuladas - gastado
	$MarginContainer/VBoxContainer3/HBoxContainer/SaldoLagrimas.text = str(saldo)
	limitar_cantidades(saldo)
	
	return saldo
	
func limitar_cantidades(saldo):
	$MarginContainer/Mejoras/ArribenoCantidad.max_value = MejorasData.arribeno.maxima_cantidad
	$MarginContainer/Mejoras/CorrentinoCantidad.max_value = MejorasData.correntino.maxima_cantidad
	$MarginContainer/Mejoras/GranaderoCantidad.max_value = MejorasData.granadero.maxima_cantidad
	$MarginContainer/Mejoras/MorenoCantidad.max_value = MejorasData.moreno.maxima_cantidad
	
	if $MarginContainer/Mejoras/ArribenoCantidad.value + floori(saldo / MejorasData.arribeno.valor) < MejorasData.arribeno.maxima_cantidad:
		$MarginContainer/Mejoras/ArribenoCantidad.max_value = $MarginContainer/Mejoras/ArribenoCantidad.value + int(saldo / MejorasData.arribeno.valor)
		
	if $MarginContainer/Mejoras/CorrentinoCantidad.value + floori(saldo / MejorasData.correntino.valor) < MejorasData.correntino.maxima_cantidad:
		$MarginContainer/Mejoras/CorrentinoCantidad.max_value = $MarginContainer/Mejoras/CorrentinoCantidad.value + int(saldo / MejorasData.correntino.valor)
		
	if $MarginContainer/Mejoras/GranaderoCantidad.value + floori(saldo / MejorasData.granadero.valor) < MejorasData.granadero.maxima_cantidad:
		$MarginContainer/Mejoras/GranaderoCantidad.max_value = $MarginContainer/Mejoras/GranaderoCantidad.value + int(saldo / MejorasData.granadero.valor)	
	
	if $MarginContainer/Mejoras/MorenoCantidad.value + floori(saldo / MejorasData.moreno.valor) < MejorasData.moreno.maxima_cantidad:
		$MarginContainer/Mejoras/MorenoCantidad.max_value = $MarginContainer/Mejoras/MorenoCantidad.value + int(saldo / MejorasData.moreno.valor)
		
func calculate_gastado():
	var gastado = 0
	gastado += $MarginContainer/Mejoras/ArribenoCantidad.value * MejorasData.arribeno.valor
	gastado += $MarginContainer/Mejoras/CorrentinoCantidad.value * MejorasData.correntino.valor
	gastado += $MarginContainer/Mejoras/GranaderoCantidad.value * MejorasData.granadero.valor
	gastado += $MarginContainer/Mejoras/MorenoCantidad.value * MejorasData.moreno.valor
	return gastado

func _on_menu_pressed():
	if calculate_saldo_lagrimas() >= 0:
		save_mejoras()
		get_tree().change_scene_to_file("res://scenes/screens/inicio.tscn")
		

func save_mejoras():
	Global.save_data.mejoras.arribenos = $MarginContainer/Mejoras/ArribenoCantidad.value
	Global.save_data.mejoras.correntinos = $MarginContainer/Mejoras/CorrentinoCantidad.value
	Global.save_data.mejoras.granaderos = $MarginContainer/Mejoras/GranaderoCantidad.value
	Global.save_data.mejoras.morenos = $MarginContainer/Mejoras/MorenoCantidad.value
	
	Global.save_data.save()


func _on_granadero_cantidad_value_changed(value):
	calculate_saldo_lagrimas()

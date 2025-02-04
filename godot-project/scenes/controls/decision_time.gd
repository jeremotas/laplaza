extends CanvasLayer
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	$MarginContainer/HBoxContainer/GranaderoButtonCard.grab_focus()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

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
	

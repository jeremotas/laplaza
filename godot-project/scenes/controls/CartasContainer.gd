extends Control

var ready_for_input = false
const oTheme = preload("res://themes/theme_hud.tres")

func change_leyenda(sLeyenda):
	get_parent().change_leyenda(sLeyenda)

func decision_elegida(sDecision, iPosicion):
	get_parent().decision_elegida(sDecision, iPosicion)

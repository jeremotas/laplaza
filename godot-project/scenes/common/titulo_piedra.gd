extends Control

@export var title = ""

func _ready() -> void:
	if title != "":
		$Label.text = tr(title.replace("\n", " "))

func set_title(sText):
	$Label.text = tr(sText.replace("\n", " "))

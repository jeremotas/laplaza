extends Control

@export var title = ""

func _ready() -> void:
	if title != "":
		$Label.text = tr(title.replace("\n", " "))

func set_title(sText):
	$Label.text = tr(sText.replace("\n", " "))

func _notification(what: int) -> void:
	if what == NOTIFICATION_TRANSLATION_CHANGED:
		_update_text()

func _update_text() -> void:
	if title != "":
		$Label.text = tr(title.replace("\n", " "))
	else:
		$Label.text = ""

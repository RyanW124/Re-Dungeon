extends "res://Scripts/Gui/CenterButton.gd"

signal pressed2(name)
var action

func _ready():
	pass
func _on_Button_pressed():
	._on_Button_pressed()
	emit_signal("pressed2", action)

func change_name(n):
	_name = n.to_lower()
	$Button.text = _name

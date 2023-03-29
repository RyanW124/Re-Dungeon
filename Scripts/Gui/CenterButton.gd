extends Control

export var _name: String
export var connect: NodePath
export(String, MULTILINE) var property_name: String
signal pressed
var hover = false
signal custom(n)

func _ready():
	connect("pressed", get_node(connect), "_on_%s_pressed"%_name)
	connect("custom", get_node(connect), "_on_pressed")
	$Button.text = _name



func _on_Button_pressed():
	emit_signal("pressed")
	emit_signal("custom", _name)
	hover = false
	if property_name and Save.in_game: Save.main.hint.hide()
	
func change_name(n):
	_name = n.to_lower()
	$Button.text = _name

func _input(event):
	if event is InputEventMouseMotion and hover:
		$Timer.start(1)
		yield($Timer, "timeout")
		if hover:
			hover = false
			Save.main.hint.display(property_name)

func _on_Button_mouse_entered():
	if property_name and Save.main.hint != null: hover = true
	

func _on_Button_mouse_exited():
	hover = false
	if Save.in_game: Save.main.hint.hide()

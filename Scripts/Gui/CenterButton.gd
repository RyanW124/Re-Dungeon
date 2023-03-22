extends Control

@export var _name: String
@export var connect: NodePath
signal pressed

func _ready():
	pressed.connect(Callable(get_node(connect), "_on_%s_pressed"%_name))
	$Button.text = _name


func _on_Button_pressed():
	emit_signal("pressed")
	

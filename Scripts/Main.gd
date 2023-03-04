extends Node2D

export(NodePath) var pause_menu
var upgrading = true

func _ready():
	Save.reset()
	pause_menu = get_node(pause_menu)
	get_tree().paused = true



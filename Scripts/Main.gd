extends Node2D

export(NodePath) var pause_menu
onready var fsm = $FSM

onready var dialogue = $CanvasLayer/CenterContainer/Dialogue

func _ready():
	Save.reset()
	pause_menu = get_node(pause_menu)
	get_tree().paused = true


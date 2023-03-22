extends Node2D

@export var pause_menu: NodePath
@onready var fsm = $FSM

@onready var dialogue = $CanvasLayer/CenterContainer/Dialogue

func _ready():
	Save.reset()
	pause_menu = get_node(pause_menu)
	get_tree().paused = true

func _on_finish():
	$Camera2D.end()
	$TileMap.end()
	$Player.end()
func transition():
	$CanvasLayer/ColorRect/AnimationPlayer.play("end")


func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene_to_file("res://Scenes/Start.tscn")

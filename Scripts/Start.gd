extends Node2D

export(String, FILE) var main

func _ready():
	Save.cam = $Camera2D
	Save.cam.detach = Save.cam.position
#	main = load(main)


func _on_Start_button_down():
	get_tree().change_scene(main)

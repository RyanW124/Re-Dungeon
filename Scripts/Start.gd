extends Control

export(String, FILE) var main

func _ready():
	pass
#	main = load(main)


func _on_Start_button_down():
	get_tree().change_scene(main)

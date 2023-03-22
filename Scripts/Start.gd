extends Node2D

#@export var main # (String, FILE)
@export_file var main
@export_node_path("Control") var settings


func _ready():
	Save.cam = $Camera2D
	Save.cam.detach = Save.cam.position
	settings = get_node(settings)

	
func _on_Settings_pressed():
	settings.show()
	
func _on_Quit_pressed():
	get_tree().quit()
	


func _on_Play_pressed():
	get_tree().change_scene_to_file(main)

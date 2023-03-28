extends Control

export(NodePath) var settings

func _ready():
	settings = get_node(settings)
	
func _on_Resume_pressed():
	pause()
	
func _on_Home_pressed():
	Save.in_game = false
	get_tree().change_scene("res://Scenes/Start.tscn")
	get_tree().paused = false
func _on_Settings_pressed():
	settings.show()
	
func _on_Quit_pressed():
	get_tree().quit()
	
func pause():
	Save.update("paused", !Save.paused)
	visible = !visible
	
func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		pause()

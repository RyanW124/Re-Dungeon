extends Control

export(NodePath) var settings

func _ready():
	settings = get_node(settings)
	
func _on_Resume_pressed():
	pause()
	
func _on_Home_pressed():
	pass
	
func _on_Settings_pressed():
	settings.show()
	
func _on_Quit_pressed():
	get_tree().quit()
	
func pause():
	if not Save.main.upgrading and not settings.visible:
		get_tree().paused = !get_tree().paused
	visible = !visible
	
func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		pause()

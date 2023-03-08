extends Control


func _ready():
	pass


func _on_Button_pressed():
	get_tree().paused = false
	get_parent().get_parent().hide()
	Save.update("upgrading", false)
	Save.player.update_stats()

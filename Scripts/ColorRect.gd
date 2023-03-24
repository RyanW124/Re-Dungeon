extends ColorRect

onready var tween = $Tween


func _ready():
	var bottom = $Label2.rect_position.y
	for i in range(4):
		var n = get_node("Label"+str(i+2))
		tween.interpolate_property(n, "rect_position:y", bottom, 
		bottom-600, 1, Tween.TRANS_ELASTIC,Tween.EASE_OUT, i/3.0)
func start():
	$Label3.text = str(Save.deaths)
	$Label5.text = Save.parseTime(true)
	tween.start()
	yield(tween, "tween_all_completed")
	$HBoxContainer.show()

func _on_Home_pressed():
	get_tree().change_scene("res://Scenes/Start.tscn")
	get_tree().paused = false
func _on_Restart_pressed():
	Save.bigreset(Save.main.level == 0)
	get_tree().reload_current_scene()
func _on_Next_pressed():
	pass

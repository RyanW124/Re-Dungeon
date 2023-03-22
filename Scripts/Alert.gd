extends Sprite2D


func _ready():
	hide()
	
func alert():
	show()
	$Timer.start(1)


func _on_Timer_timeout():
	hide()

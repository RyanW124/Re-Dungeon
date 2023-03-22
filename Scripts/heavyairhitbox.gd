extends "res://Scripts/hitbox.gd"

func kb(body=null):
	return Vector2.DOWN
func hit(body):
	super.hit(body)
	$Timer.start(.1)


func _on_Timer_timeout():
	hit = []
	

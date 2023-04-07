extends "res://Scripts/Camera2D.gd"


func _ready():
	pass

func cut_to(pos, time=1.5, t2 = 1.5):
	Save.update("cutscene", true)
	position = Save.cam.position
	make_current()
	detach = pos
	$Timer2.start(time)
	yield($Timer2, "timeout")
	detach = null
	$Timer2.start(t2)
	yield($Timer2, "timeout")
	Save.update("cutscene", false)
	Save.cam.make_current()

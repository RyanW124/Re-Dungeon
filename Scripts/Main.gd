extends Node2D


func _ready():
	get_tree().paused = true
#	get_tree().paused = true
func reset():
	for i in get_children():
		if i.has_method("reset"):
			i.reset()

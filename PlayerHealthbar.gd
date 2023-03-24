extends "res://Scripts/Healthbar.gd"

func ready():
	parent = Save.player
	max_value = parent.max_health
	prev = 0
#	tween.tween_property(self, "scale", Vector2.ZERO, 0.1)

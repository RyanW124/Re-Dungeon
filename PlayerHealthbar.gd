extends "res://Scripts/Healthbar.gd"

func ready():
	parent = Save.player
	max_value = parent.max_health

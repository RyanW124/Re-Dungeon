extends "res://Scripts/Healthbar.gd"

func ready():
	parent = get_tree().root.get_child(1).get_node("Player")
	max_value = parent.max_health

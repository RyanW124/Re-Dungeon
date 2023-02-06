extends "res://Scripts/States/Attack1.gd"
class_name AirAttack

func _ready():
	anim = "airattack"
func update(_delta):
	player.move(_delta)
	.update(_delta)

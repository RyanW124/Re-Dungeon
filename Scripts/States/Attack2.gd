extends "res://Scripts/States/Attack1.gd"
class_name Attack2

func _ready():
	anim = "attack2"

func update(_delta: float) -> void:
	.update(_delta)
	player.move(_delta)

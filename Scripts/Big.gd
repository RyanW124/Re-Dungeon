extends "res://Scripts/Enemy.gd"
class_name Big

@onready var mid = $mid

func _ready():
	$hitbox.damage = 2
	$RayCast2D.add_exception(Save.player)
#func _physics_process(delta):
#	print(vel)

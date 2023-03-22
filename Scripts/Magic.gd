extends "res://Scripts/Enemy.gd"
class_name Magic

@onready var ray = $RayCast2D

func _ready():
	fsm = $FSM
	ray.add_exception(Save.player)
func spawn():
	return position
func direction():
	return Save.player.mid.global_position - position
func shoot():
	var p = projectile.instantiate()
	p.init(direction(), self, 0)
	p.target = "Player"
	p.speed = 30
	get_tree().root.get_node("Main").add_child(p)
	$animation.play("attack")
func update_ray():
	ray.target_position = direction()
	

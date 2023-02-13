extends "res://Scripts/States/State.gd"

var c = false
func _ready():
	name = "Idle"

func update(_delta):
	if !player.ray.is_colliding() and player.in_range():
#		print(1, player.ray.is_colliding(), player.position.distance_to(Save.player.position))
		state_machine.transition_to("Aggro")
	player.update_ray()

func enter(_msg := {}) -> void:
	player.get_node("animation").play("flight")

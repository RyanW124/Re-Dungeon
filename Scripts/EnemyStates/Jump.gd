extends "res://Scripts/States/State.gd"
func _ready():
	name = "Jump"
func update(_delta: float) -> void:
	player.get_node("animation").play("jump")
	
		

# Virtual function. Corresponds to the `_physics_process()` callback.
func physics_update(_delta: float) -> void:
	if player.vel.y >= 0:
		state_machine.transition_to("Fall")
func enter(_msg := {}) -> void:
	player.get_node("animation").play("jump")
	player.jump()

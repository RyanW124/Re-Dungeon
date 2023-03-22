extends "res://Scripts/States/InAir.gd"
class_name DJump
func update(_delta: float) -> void:
	super.update(_delta)
	if player.vel.y >= 0:
		state_machine.transition_to("Fall2")

# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_msg := {}) -> void:
#	player.get_node("animation").play("Jump")
	player.djump()


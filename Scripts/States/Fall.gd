extends "res://Scripts/States/InAir.gd"
class_name Fall


# Virtual function. Corresponds to the `_process()` callback.
func update(_delta: float) -> void:
	.update(_delta)
	player.get_node("animation").play("fall")
#	if Input.is_action_just_pressed("Jump"):
#		state_machine.transition_to("Jump")

# Virtual function. Corresponds to the `_physics_process()` callback.
func physics_update(_delta: float) -> void:
	.physics_update(_delta)
	if Input.is_action_just_pressed("Jump"):
		state_machine.transition_to("DJump")		
	elif player.is_on_floor():
		state_machine.transition_to("Idle")
	elif player.is_on_wall():
		state_machine.transition_to("Climb")
	elif Input.is_action_pressed("Shoot") and state_machine.get_node("Cast").ready:
		state_machine.transition_to("Cast")
		
func anim_update():
	pass

# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_msg := {}) -> void:
#	player.get_node("animation").play("Jump")
	player.get_node("animation").play("fall")
	if player.buffer.time_left!=0:
		state_machine.transition_to("Jump")


# Virtual function. Called by the state machine before changing the active state. Use this function
# to clean up the state.
func exit() -> void:
	pass

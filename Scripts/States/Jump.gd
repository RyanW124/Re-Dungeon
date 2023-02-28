extends "res://Scripts/States/InAir.gd"
class_name Jump

# Virtual function. Corresponds to the `_process()` callback.
func update(_delta: float) -> void:
#	if Input.is_action_just_pressed("Jump") and (player.is_on_floor() or player.is_on_wall()):
#		state_machine.transition_to("Jump")
	if .update(_delta): return
	if player.vel.y >= 0:
		state_machine.transition_to("Fall")
	elif Input.is_action_just_pressed("Jump"):
		state_machine.transition_to("DJump")	
		
func enter(_msg := {}) -> void:
	.enter()
	player.jump()

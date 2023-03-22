extends "res://Scripts/States/InAir.gd"
class_name Jump

# Virtual function. Corresponds to the `_process()` callback.
func update(_delta: float) -> void:
#	if Input.is_action_just_pressed("Jump") and (player.is_on_floor() or player.is_on_wall()):
#		state_machine.transition_to("Jump")
	if super.update(_delta): return
	
	if Input.is_action_just_pressed("Up"):
		state_machine.transition_to("DJump")	
	elif player.vel.y >= 0:
		state_machine.transition_to("Fall")
		
func enter(_msg := {}) -> void:
	super.enter()
	player.jump()

extends "res://Scripts/States/State.gd"
class_name Idle

# Virtual function. Corresponds to the `_process()` callback.
func update(_delta: float) -> void:
	if player.buffer.time_left!=0 or (Input.is_action_just_pressed("Jump") and (player.is_on_floor() or player.is_on_wall())):
		state_machine.transition_to("Jump")
	elif Input.is_action_pressed("Left") or Input.is_action_pressed("Right"):
		state_machine.transition_to("Walk")
	elif Input.is_action_pressed("Slide"):
		state_machine.transition_to("Crouch")
	elif Input.is_action_pressed("Shoot") and state_machine.get_node("Cast").ready:
		state_machine.transition_to("Cast")
	elif Input.is_action_just_pressed("Attack1"):
		state_machine.transition_to("Attack1")
	elif Input.is_action_just_pressed("Heavy"):
		state_machine.transition_to("Heavy")	
	elif Input.is_action_just_pressed("Heavy"):
		state_machine.transition_to("Heavy")
	elif Input.is_action_just_pressed("Ladder") and player.touching_ladder():
		state_machine.transition_to("Ladder")
		
		
	
		
# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_msg := {}) -> void:
	player.get_node("animation").play("idle")
	player.change_collide("Idle")
	player.combo = 0

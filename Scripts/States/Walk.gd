extends "res://Scripts/States/State.gd"
class_name Walk
# Virtual function. Corresponds to the `_process()` callback.
func update(_delta: float) -> void:
	
	player.get_node("animation").play("walk")
	player.vel.x = 0
	player.move(_delta)
	player.update_anim()
	if !Input.is_action_pressed("Left") and !Input.is_action_pressed("Right"):
		state_machine.transition_to("Idle")
				
	elif Input.is_action_just_pressed("Up") and (player.is_on_floor() or player.is_on_wall()):
		state_machine.transition_to("Jump")
		
	elif player.vel.y > 0:
		state_machine.transition_to("Fall")
	elif Input.is_action_just_pressed("Down"):
		if abs(player.move_vel.x) == player.speed:
			state_machine.transition_to("Slide")
		else:
			state_machine.transition_to("Crouch")			
	elif Input.is_action_pressed("Shoot") and state_machine.get_node("Cast").ready:
		state_machine.transition_to("Cast")
	elif Input.is_action_just_pressed("Attack1"):
		state_machine.transition_to("Attack2")	
	elif Input.is_action_just_pressed("Heavy"):
		state_machine.transition_to("Heavy")	
	elif Input.is_action_just_pressed("Ladder") and player.touching_ladder():
		state_machine.transition_to("Ladder")
		
		


# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(msg=null):
#	player.get_node("dirt").emitting = true
	player.get_node("dirt").one_shot = false
	player.get_node("dirt").restart()


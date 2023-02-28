extends "res://Scripts/States/State.gd"
func update(_delta: float):
#	if Input.is_action_just_pressed("Jump") and (player.is_on_floor() or player.is_on_wall()):
#		state_machine.transition_to("Jump")
	player.move(_delta)
	player.update_anim()
	
	if Input.is_action_pressed("Shoot") and state_machine.get_node("Cast").ready:
		state_machine.transition_to("Cast")	
	elif Input.is_action_just_pressed("Attack1"):
		state_machine.transition_to("AirAttack")	
	elif Input.is_action_just_pressed("Heavy"):
		state_machine.transition_to("HeavyAir")	
	else:
		return false
	return true


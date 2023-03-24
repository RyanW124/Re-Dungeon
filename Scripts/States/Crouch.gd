extends "res://Scripts/States/State.gd"
class_name Crouch

func update(_delta: float) -> void:
	player.move(_delta, 0.3)
	player.update_anim()
	player.get_node("animation").play("crouch")	
	if not Input.is_action_pressed("Down"):
		player.change_collide("Idle")
		if player.is_stuck():
			player.change_collide("Crouch")
		else:
			state_machine.transition_to("Idle")
			
		
	
func enter(msg=null):
#	player.get_node("animation").play("Jump")
	player.get_node("animation").play("crouch")
	player.change_collide("Crouch")


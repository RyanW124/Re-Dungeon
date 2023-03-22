extends "res://Scripts/States/State.gd"
class_name Slide

var right
# Virtual function. Corresponds to the `_process()` callback.
func update(_delta: float) -> void:
#	player.move(_delta)
	player.get_node("animation").play("slide")

	player.update_anim()
	player.vel.x = player.accel
	var s = player.accel < 0
	
	player.accel += _delta*player.speed if s else -_delta*player.speed
	if s != (player.accel < 0) or player.accel == 0 or player.move_vel.x == 0:
		check()
		player.accel = 0
		return

func check():
	player.change_collide("Idle")
	if player.is_stuck():
		state_machine.transition_to("Crouch")
	else:	
		state_machine.transition_to("Idle")
func anim_update():
	if Input.is_action_pressed("Down") and player.accel != 0:
		return
	check()

# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_msg := {}) -> void:
#	player.get_node("animation").play("Jump")
	player.get_node("animation").play("slide")
	player.change_collide("Slide")
	right = player.vel.x > 0


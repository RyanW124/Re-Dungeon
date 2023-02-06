extends "res://Scripts/States/State.gd"
class_name Attack1
var anim = "attack1"
# Virtual function. Corresponds to the `_process()` callback.
func update(_delta: float) -> void:
	player.get_node("animation").play(anim)
	
		
func anim_update():
	if prev == "Jump":
		prev = "Fall"
	elif prev == "DJump":
		prev = "Fall2"
	state_machine.transition_to(prev)

func enter(_msg := {}) -> void:
	player.get_node("animation").play(anim)
#	player.cam.shake(50)


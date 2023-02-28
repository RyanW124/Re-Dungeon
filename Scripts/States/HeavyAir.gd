extends "res://Scripts/States/State.gd"
class_name HeavyAir
# Virtual function. Corresponds to the `_process()` callback.
var state = 0
var multi = 4
var anim = ["airattack3", "airattack3-loop", "airattack3-end"]
func update(_delta: float) -> void:
	if player.is_on_floor():
		state = 2
	player.get_node("animation").play(anim[state])
		
		
	
		
func anim_update():
	if state == 0:
		state = 1
	if state == 2:
		state_machine.transition_to("Idle")
		
func exit():
	player.gravity /= multi
	Save.cam.shake(100)
	

func enter(_msg := {}) -> void:
	state = 0
	player.gravity *= multi
	player.get_node("animation").play(anim[state])


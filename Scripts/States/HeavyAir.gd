extends "res://Scripts/States/State.gd"
class_name HeavyAir
# Virtual function. Corresponds to the `_process()` callback.
var state = 0
var multi = 4
export var cooldown:float
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
	

func enter(msg=null):
	if !$Timer.is_stopped():
		if prev == "Jump":
			prev = "Fall"
		elif prev == "DJump":
			prev = "Fall2"
		state_machine.transition_to(prev)
		return
	$Timer.start(cooldown)
	state = 0
	player.gravity *= multi
	player.get_node("animation").play(anim[state])
	


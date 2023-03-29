extends "res://Scripts/States/State.gd"
class_name Heavy
export var cooldown:float
var anim = ["attack3-hold", "attack3"]
#var anim = ["Idle", "Idle"]
var hold = 0
var state = 0
#func _ready():
#	hitbox = get_node(hitbox)
func update(_delta):
	if state == 0:
		hold = min(hold + _delta, 1)
		if Input.is_action_just_released("Heavy"):
			state = 1
			player.get_node("Heavy").dmgmulti += hold * 3
			player.get_node("animation").flash()
			
	player.get_node("animation").play(anim[state])
	
	
func anim_update():
	if state == 1:
		state_machine.transition_to(prev)
func enter(msg=null):
	state = 0
	hold = 0
	if !$Timer.is_stopped():
		if prev == "Jump":
			prev = "Fall"
		elif prev == "DJump":
			prev = "Fall2"
		state_machine.transition_to(prev)

		return
	$Timer.start(cooldown)
	player.get_node("animation").play(anim[state])
	player.get_node("animation").flash()
	
func exit():
	player.get_node("Heavy").dmgmulti -= hold
	

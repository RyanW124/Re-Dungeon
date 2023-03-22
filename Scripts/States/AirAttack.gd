extends "res://Scripts/States/Attack1.gd"
class_name AirAttack

var reset = false
func _ready():
	anim = "airattack"
func update(_delta):
	player.move(_delta)
	super.update(_delta)
	if Input.is_action_just_pressed("Jump"):
		player.buffer.start(.3)
func anim_update():
	if reset:
		state_machine.transition_to("Fall")
	else:
		super.anim_update()
func some_event():
	reset = true
	player.add_combo()
func enter(msg:= {}):
	reset = false

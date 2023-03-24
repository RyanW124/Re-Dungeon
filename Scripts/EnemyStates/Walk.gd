extends "res://Scripts/States/State.gd"

var d = Vector2.ZERO

func _ready():
	name = "Walk"
func update(_delta: float) -> void:
	d = player.get_d()
	if d == Vector2.ZERO:
		state_machine.transition_to("Idle")
		return
	player.vel.x += d.x * player.speed
	if player.vel.y > 0:
		state_machine.transition_to("Fall")
	elif d.y < 0:
		state_machine.transition_to("Jump")
	player.update_anim()
	player.get_node("animation").play("walk")
	

func enter(msg=null):
	player.get_node("animation").play("walk")
	player.passed = true

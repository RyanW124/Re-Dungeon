extends "res://Scripts/States/State.gd"

var d = Vector2.ZERO

func _ready():
	name = "Walk"
func update(_delta: float) -> void:
	var s = player.side()
	if (player.prev < 8) != (s < 8) and (player.prev < 1) == (s < 1):
		player.passed = true
#	print(passed)
	prev = s
	if player.passed:
		d = Vector2.ZERO
		if 1<player.get_distance() and player.get_distance()< 20:
			player.alert()
			d = Vector2.ZERO
			for i in [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]:
				if player.get_distance(i) == player.get_distance() -1:
	#				fsm.direction = i
					d = i
					player.passed = false
					break
		else:
			player.alert = not player.has_pos()
	if d == Vector2.ZERO:
		state_machine.transition_to("Idle")
		return
	if player.vel.y > 0:
		state_machine.transition_to("Fall")
	elif player.vel.y < 0:
		state_machine.transition_to("Jump")
	player.update_anim()
	player.get_node("animation").play("walk")
	

func enter(_msg := {}) -> void:
	player.get_node("animation").play("walk")

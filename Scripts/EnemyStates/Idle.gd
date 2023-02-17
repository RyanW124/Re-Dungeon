extends "res://Scripts/States/State.gd"

var d = Vector2.ZERO

func _ready():
	name = "Idle"
	
func update(_delta: float) -> void:
	player.get_node("animation").play("idle")	
	if 1<player.get_distance() and player.get_distance()< 20:
		player.alert()
		d = Vector2.ZERO
		for i in [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]:
			if player.get_distance(i) == player.get_distance() -1:
#				fsm.direction = i
				d = i
				player.passed = false
				break
		if d.y < 0:
			state_machine.transition_to("Jump")
		elif d.x != 0:
			state_machine.transition_to("Walk")
	elif player.get_distance() <=1:
		state_machine.transition_to("Attack")
		

func enter(_msg := {}) -> void:
	player.get_node("animation").play("idle")

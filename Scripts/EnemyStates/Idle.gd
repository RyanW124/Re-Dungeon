extends "res://Scripts/States/State.gd"

var d = Vector2.ZERO

func _ready():
	name = "Idle"
	
func update(_delta: float) -> void:
	player.get_node("animation").play("idle")	
	d = player.get_d()
	if d.y < 0:
		state_machine.transition_to("Jump")
	elif player.vel.y > 0:
		state_machine.transition_to("Fall")
		
	elif d.x != 0:
		state_machine.transition_to("Walk")
	elif player.get_distance() <=1:
		state_machine.transition_to("Attack")
		

func enter(msg=null):
	player.get_node("animation").play("idle")

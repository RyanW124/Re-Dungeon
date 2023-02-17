extends "res://Scripts/States/State.gd"
func _ready():
	name = "Attack"
# Virtual function. Corresponds to the `_process()` callback.
func update(_delta: float) -> void:
	var hitbox = player.get_node("hitbox") 
	var left = Save.player.position < player.position
	hitbox.position.x = abs(hitbox.position.x)
	player.get_node("animation").flip_h = left
	if left: hitbox.position.x *= -1
	player.get_node("animation").play("attack1")
	if player.dist >1:
		state_machine.transition_to("Idle")
	
		

func enter(_msg := {}) -> void:
	player.get_node("animation").play("attack1")


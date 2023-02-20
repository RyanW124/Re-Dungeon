extends "res://Scripts/States/State.gd"

func _ready():
	name = "Fall"

# Virtual function. Corresponds to the `_process()` callback.
func update(_delta: float) -> void:
	var d = player.get_d()
	if d == Vector2.ZERO:
		state_machine.transition_to("Idle")
		return
	player.vel.x += d.x * player.speed
	if player.is_on_floor():
		state_machine.transition_to("Idle")
	

func anim_update():
	player.get_node("animation").play("fall")

func enter(_msg := {}) -> void:
	player.get_node("animation").play("jumpfall")


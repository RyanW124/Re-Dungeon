extends "res://Scripts/States/State.gd"

func _ready():
	name = "Hurt"
# Virtual function. Corresponds to the `_process()` callback.
func update(_delta: float) -> void:
	if player.off_multi == 0:
		if prev == "Attack": prev = "Aggro"
		state_machine.transition_to(prev)
		
		

func anim_update():
	state_machine.transition_to(prev)

# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(msg=null):
	player.get_node("animation").play("hurt")


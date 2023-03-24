extends "res://Scripts/States/State.gd"

var kb_dir

func _ready():
	name = "Hurt"
func update(_delta: float) -> void:
	if player.off_multi == 0:
		state_machine.transition_to(prev)

func anim_update():
	state_machine.transition_to(prev)
func enter(msg=null):
	player.get_node("animation").play("hurt")
	player.right = player.offset.x > 0

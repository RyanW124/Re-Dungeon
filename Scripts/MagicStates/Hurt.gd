extends State


func _ready():
	name = "Hurt"
func update(_delta: float) -> void:
	player.get_node("animation").play("hurt")
	
	if player.off_multi == 0:
		state_machine.transition_to(prev)

func anim_update():
	state_machine.transition_to(prev)
func enter(msg=null):
	player.get_node("animation").play("hurt")

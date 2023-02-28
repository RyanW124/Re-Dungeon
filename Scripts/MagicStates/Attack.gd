extends State


func _ready():
	name = "Attack"

func enter(msg := {}):
	player.shoot()


func anim_update():
	state_machine.transition_to("Idle")

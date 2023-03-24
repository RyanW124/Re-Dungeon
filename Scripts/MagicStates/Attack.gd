extends State


func _ready():
	name = "Attack"

func enter(msg=null):
	player.shoot()


func anim_update():
	state_machine.transition_to("Idle")

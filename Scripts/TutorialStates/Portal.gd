extends TutState

var state = 0

func _ready():
	name = "Portal"
func on_d_closed():
	if state == 0:
		state += 1
		player.dialogue.display("When the portal closes or by pressing %s again, you would be teleported back to the position of the portal" % Save.get_key("Portal"))
	elif state == 1:
		state_machine.transition_to("Idle", name)
func enter(msg=null):
	state = 0
	player.dialogue.display("Press %s to open a portal\nThis would use 2 mana" % Save.get_key("Portal"))

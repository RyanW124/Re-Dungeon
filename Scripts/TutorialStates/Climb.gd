extends TutState

var state = 0

func _ready():
	name = "Climb"
func on_d_closed():
	if state == 0:
		state += 1
		player.dialogue.display("Use %s, %s, %s, %s to move on the ladder" % [Save.get_key("Left"), Save.get_key("Right"), Save.get_key("Up"), Save.get_key("Down")])
	elif state == 1:
		state_machine.transition_to("Idle", name)
func enter(msg=null):
	state = 0
	player.dialogue.display("Press %s to attach to ladder\nPress again to detach from ladder" % Save.get_key("Ladder"))

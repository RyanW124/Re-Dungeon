extends TutState

var state = 0

func _ready():
	name = "Slide"
func on_d_closed():
	if state == 0:
		state += 1
		player.dialogue.display("The longer you hold, the longer you slide")
	
func on_act(_name):
	if _name == "DJump":
		state_machine.transition_to("DJump")
func enter(msg := {}):
	state = 0
	player.dialogue.display("Press %s while standing still to crouch\nPress while moving to slide" % Save.get_key("Down"))

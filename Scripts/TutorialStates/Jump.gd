extends TutState


func _ready():
	name = "Jump"
	
func on_act(_name):
	if _name == "Slide":
		state_machine.transition_to("Slide")

func enter(msg := {}):
	player.dialogue.display("Press %s to jump" % Save.get_key("Up"))

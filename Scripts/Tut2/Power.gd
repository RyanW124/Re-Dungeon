extends TutState


func _ready():
	name = "Power"
	
func on_d_closed():
	state_machine.transition_to("Idle", name)
func enter(msg=null):
	player.dialogue.display("Press %s to interact with computer" % Save.get_key("Power Up"))

extends TutState


func _ready():
	name = "Break"
	
func on_d_closed():
	state_machine.transition_to("Idle", name)
func enter(msg=null):
	player.dialogue.display("Press %s to jump" % Save.get_key("Up"))

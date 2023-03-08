extends TutState


func _ready():
	name = "Idle"

func on_act(_name):
	if _name == "Jump":
		state_machine.transition_to("Jump")

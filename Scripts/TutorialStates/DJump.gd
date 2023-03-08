extends TutState

var state = 0
onready var cam = $Camera2D

func _ready():
	name = "DJump"
func on_d_closed():

	if state == 0:
		state += 1
		player.dialogue.display("Grabbing a wall resets your double jump")
	
func on_act(_name):
	if _name == "Fight":
		state_machine.transition_to("Fight")
func enter(msg := {}):
	state = 0
	Save.update("cutscene", true)
	cam.position = Save.cam.position
	cam.make_current()
	cam.detach = $pos.position
	$Timer.start(1.5)
	yield($Timer, "timeout")
	cam.detach = null
	$Timer.start(1.5)
	yield($Timer, "timeout")
	Save.update("cutscene", false)
	Save.cam.make_current()
	player.dialogue.display("The platform is too high for a single jump!\nJump in the air to perform a double jump")

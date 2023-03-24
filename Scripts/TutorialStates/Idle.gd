extends TutState

var order = ["Idle", "Jump", "Slide", "DJump", "Fight", "Climb", "Portal"]
var waiting = ""
var doing = false
func _ready():
	name = "Idle"
func on_act(_name):
#	print(_name, " ", waiting)
	if _name == waiting:
		state_machine.transition_to(waiting)
func update(_delta):
	if doing:
		doing = false
		player.dialogue.display("Press %s and %s to move" % [Save.get_key("Left"), Save.get_key("Right")])
	
func on_d_closed():
	waiting = order[1]
#	print(1)
	Save.state = "Idle"
func enter(msg=null):
	var index = order.find(msg)
	doing = false
	if index == -1:
		doing = true
	elif index + 1 >= len(order):
		waiting = ""
	else:
		waiting = order[index+1]
#	print(waiting)
	

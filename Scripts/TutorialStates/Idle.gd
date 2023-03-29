extends TutState

var order = ["Idle", "Break", "Power"]
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
		player.dialogue.display("Every game, your stats start at 0\nCollect coins to upgrade")
	
func on_d_closed():
	waiting = order[1]
#	print(1)
	Save.state = "Idle"
	Save.update("upgrading", true)
	Save.main.overlay.get_node("Buy").visible = true
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
	

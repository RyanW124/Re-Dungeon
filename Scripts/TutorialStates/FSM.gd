extends StateMachine

export var waiting:=""

func _ready():
	if not waiting:
		waiting = Save.state
	if waiting != "":
		get_parent().upgrade = true
#		Save.update("upgrading", true)
#		get_parent().get_node("CanvasLayer/Overlay/Buy").visible = true
	state.active = false
	state = get_node(default)
	state.active = true
	state.enter(waiting)
	Save.player.fsm.connect("transitioned", self, "on_tran")

func on_act(_name):
	state.on_act(_name)
func _on_dialogue_closed():
	state.on_d_closed()
#func _process(delta):
#	print(state)
func on_tran(prev, name):
	state.on_tran(prev, name)
func transition_to(target_state_name: String, msg=null) -> void:
	if target_state_name == "Idle":
		Save.state = state.name
	.transition_to(target_state_name, msg)

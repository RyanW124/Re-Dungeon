extends StateMachine


func _ready():
	Save.player.fsm.connect("transitioned", self, "on_tran")

func on_act(_name):
	state.on_act(_name)
func _on_dialogue_closed():
	state.on_d_closed()
#func _process(delta):
#	print(state)
func on_tran(prev, name):
	state.on_tran(prev, name)

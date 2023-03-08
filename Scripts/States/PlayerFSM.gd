extends StateMachine


func _ready():
	pass

func transition_to(target_state_name: String, msg: Dictionary = {}) -> void:
	if Save.player.input_lock and target_state_name == "Walk":
		return
	.transition_to(target_state_name, msg)

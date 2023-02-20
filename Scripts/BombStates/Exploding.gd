extends State


func _ready():
	pass
func enter(msg := {}):
	$Timer.start(2)
	player.get_node("Spark").emitting = true
	
	
func exit():
	player.get_node("Spark").emitting = false
	

func _on_Timer_timeout():
	state_machine.transition_to("Explode")
	
	

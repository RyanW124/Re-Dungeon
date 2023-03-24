extends State
class_name QuickFall

func _ready():
	pass
# Virtual function. Corresponds to the `_process()` callback.
func update(_delta: float) -> void:
	player.get_node("animation").play("fall")
#	if Input.is_action_just_pressed("Jump"):
#		state_machine.transition_to("Jump")

# Virtual function. Corresponds to the `_physics_process()` callback.
func physics_update(_delta: float) -> void:
	if Input.is_action_just_pressed("Jump"):
		player.buffer.start(.1)
	if player.is_on_floor():
		state_machine.transition_to("Idle")
	elif player.is_on_wall():
		state_machine.transition_to("Climb")
		

# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(msg=null):
#	player.get_node("animation").play("Jump")
	player.get_node("animation").play("fall")
	player.gravity *= 5.0
func exit():
	player.gravity /= 5.0
	

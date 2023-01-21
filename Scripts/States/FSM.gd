# Generic state machine. Initializes states and delegates engine callbacks
# (_physics_process, _unhandled_input) to the active state.
class_name StateMachine
extends Node

# Emitted when transitioning to a new state.
signal transitioned(state_name)
var direction
var state


func _ready() -> void:
	state = get_node("Idle")
	yield(owner, "ready")
	# The state machine assigns itself to the State objects' state_machine property.
	for child in get_children():
		child.state_machine = self
		child.player = get_parent()
	state.enter()


# The state machine subscribes to node callbacks and delegates them to the state objects.
func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)


func _process(delta: float) -> void:
	state.update(delta)
#	print(state.name)
#	print(state)
	


func _physics_process(delta: float) -> void:
	state.physics_update(delta)


# This function calls the current state's exit() function, then changes the active state,
# and calls its enter function.
# It optionally takes a `msg` dictionary to pass to the next state's enter() function.
func transition_to(target_state_name: String, msg: Dictionary = {}) -> void:
	# Safety check, you could use an assert() here to report an error if the state name is incorrect.
	# We don't use an assert here to help with code reuse. If you reuse a state in different state machines
	# but you don't want them all, they won't be able to transition to states that aren't in the scene tree.
	if target_state_name == state.name:
		return
	if not has_node(target_state_name):
		return
	var n = state.name
	state.exit()
#	if get_parent().is_in_group("Enemies"): print(target_state_name)
	state = get_node(target_state_name)
	state.prev = n
	state.enter(msg)
	emit_signal("transitioned", state.name)



func _on_animation_animation_finished():
	state.anim_update() # Replace with function body.



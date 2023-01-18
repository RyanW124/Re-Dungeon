extends Node
class_name Crouch
# Reference to the state machine, to call its `transition_to()` method directly.
# That's one unorthodox detail of our state implementation, as it adds a dependency between the
# state and the state machine objects, but we found it to be most efficient for our needs.
# The state machine node will set it.
var state_machine = null
var player = null
var prev = null

# Virtual function. Receives events from the `_unhandled_input()` callback.
func handle_input(_event: InputEvent) -> void:
	pass


# Virtual function. Corresponds to the `_process()` callback.
func update(_delta: float) -> void:
	player.move(_delta, 0.3)
	player.update_anim()
	player.get_node("animation").play("crouch")	
	if not Input.is_action_pressed("Slide"):
		player.change_collide("Idle")
		if player.is_stuck():
			player.change_collide("Crouch")
		else:
			state_machine.transition_to("Idle")
			
		
		

# Virtual function. Corresponds to the `_physics_process()` callback.
func physics_update(_delta: float) -> void:
	pass
		
func anim_update():
	pass
#	player.change_collide("Idle")
#	if player.is_on_ceiling():
#		state_machine.transition_to("Crouch")
#	else:	
#		state_machine.transition_to("Idle")

# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_msg := {}) -> void:
#	player.get_node("animation").play("Jump")
	player.get_node("animation").play("crouch")
	player.change_collide("Crouch")
	


# Virtual function. Called by the state machine before changing the active state. Use this function
# to clean up the state.
func exit() -> void:
	pass
#	player.get_node("CollisionShape2D").disabled = false
#	player.get_node("Slide_collide").disabled = true
#	player.change_collide("Slide")
	

extends Node
class_name Walk
# Reference to the state machine, to call its `transition_to()` method directly.
# That's one unorthodox detail of our state implementation, as it adds a dependency between the
# state and the state machine objects, but we found it to be most efficient for our needs.
# The state machine node will set it.
var state_machine = null
var player = null
var right = true
var prev = null
# Virtual function. Receives events from the `_unhandled_input()` callback.
func handle_input(_event: InputEvent) -> void:
	pass


# Virtual function. Corresponds to the `_process()` callback.
func update(_delta: float) -> void:
	
	player.get_node("animation").play("walk")
	player.vel.x = 0
	player.move(_delta)
	player.update_anim()
	if Input.is_action_pressed("Left") == Input.is_action_pressed("Right"):
		state_machine.transition_to("Idle")
				
	elif Input.is_action_just_pressed("Jump") and (player.is_on_floor() or player.is_on_wall()):
		state_machine.transition_to("Jump")
		
	elif not Input.is_action_pressed("Left") and not Input.is_action_pressed("Right"):
		state_machine.transition_to("Idle")
	elif player.vel.y > 0:
		state_machine.transition_to("Fall")
	elif Input.is_action_just_pressed("Slide"):
		if abs(player.vel.x) == player.speed:
			state_machine.transition_to("Slide")
		else:
			state_machine.transition_to("Crouch")			
	elif Input.is_action_pressed("Shoot") and state_machine.get_node("Cast").ready:
		state_machine.transition_to("Cast")
		
		


# Virtual function. Corresponds to the `_physics_process()` callback.
func physics_update(_delta: float) -> void:
	pass


# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_msg := {}) -> void:
	player.get_node("dirt").emitting = true
	player.get_node("dirt").one_shot = false
	player.get_node("dirt").restart()


# Virtual function. Called by the state machine before changing the active state. Use this function
# to clean up the state.
func exit() -> void:
	player.get_node("dirt").one_shot = true


func anim_update():
	pass

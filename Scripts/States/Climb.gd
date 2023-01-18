extends Node
class_name Climb
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
	player.move(_delta)
	player.get_node("animation").play("climb")
	
	if Input.is_action_just_pressed("Jump"):
		state_machine.transition_to("Jump")

# Virtual function. Corresponds to the `_physics_process()` callback.
func physics_update(_delta: float) -> void:
	player.vel.y = min(player.vel.y, 100)
	for i in range(player.get_slide_count()):
		var collision = player.get_slide_collision(i)
		if collision.normal.x == 0:
			continue
		player.get_node("animation").flip_h = collision.normal.x > 0
#		player.move_and_slide(-collision.normal)
#		print(-collision.normal)
		break
	if not player.is_on_wall():
		state_machine.transition_to("Fall")
	if player.is_on_floor():
		state_machine.transition_to("Idle")
	
	
		
func anim_update():
	pass

# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_msg := {}) -> void:
#	player.get_node("animation").play("Jump")
	player.get_node("animation").play("climb")


# Virtual function. Called by the state machine before changing the active state. Use this function
# to clean up the state.
func exit() -> void:
	pass

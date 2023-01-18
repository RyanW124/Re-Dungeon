extends Node
class_name Slide
# Reference to the state machine, to call its `transition_to()` method directly.
# That's one unorthodox detail of our state implementation, as it adds a dependency between the
# state and the state machine objects, but we found it to be most efficient for our needs.
# The state machine node will set it.
var state_machine = null
var player = null
var right: bool
var prev = null
# Virtual function. Receives events from the `_unhandled_input()` callback.
func handle_input(_event: InputEvent) -> void:
	pass


# Virtual function. Corresponds to the `_process()` callback.
func update(_delta: float) -> void:
#	player.move(_delta)
	player.get_node("animation").play("slide")

	player.update_anim()
	player.vel.x = player.accel
	var s = player.accel < 0
	player.accel += _delta*player.speed if s else -_delta*player.speed
	if s != (player.accel < 0):
		check()
		player.accel = 0

# Virtual function. Corresponds to the `_physics_process()` callback.
func physics_update(_delta: float) -> void:
	pass
func check():
	player.change_collide("Idle")
	if player.is_stuck():
		state_machine.transition_to("Crouch")
	else:	
		state_machine.transition_to("Idle")
func anim_update():
	if Input.is_action_pressed("Slide") and player.accel != 0:
		return
	check()

# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_msg := {}) -> void:
#	player.get_node("animation").play("Jump")
	player.get_node("animation").play("slide")
	player.change_collide("Slide")
	right = player.vel.x > 0


# Virtual function. Called by the state machine before changing the active state. Use this function
# to clean up the state.
func exit() -> void:
	pass
#	player.get_node("CollisionShape2D").disabled = false
#	player.get_node("Slide_collide").disabled = true
#	player.change_collide("Slide")
	

extends Node
class_name Cast
# Reference to the state machine, to call its `transition_to()` method directly.
# That's one unorthodox detail of our state implementation, as it adds a dependency between the
# state and the state machine objects, but we found it to be most efficient for our needs.
# The state machine node will set it.
var state_machine = null
var player = null
var prev = null
var loop = false
var ready = true

# Virtual function. Receives events from the `_unhandled_input()` callback.
func handle_input(_event: InputEvent) -> void:
	pass


# Virtual function. Corresponds to the `_process()` callback.
func update(_delta: float) -> void:
	shoot()
	player.move(_delta)
	player.update_anim()
	
	player.get_node("animation").play("cast-loop" if loop else "cast")
	if loop and not Input.is_action_pressed("Shoot"):
		next()
	
	

# Virtual function. Corresponds to the `_physics_process()` callback.
func physics_update(_delta: float) -> void:
	pass
#	if Input.is_action_just_pressed("Jump"):
#		player.buffer.start(.1)
#	if player.is_on_floor():
#		state_machine.transition_to("Idle")
#	elif player.is_on_wall():
#		state_machine.transition_to("Climb")
		
func anim_update():
	
	if Input.is_action_pressed("Shoot"):
		loop = true
		player.get_node("animation").play("cast-loop")
		return
	next()
func next():
	$Wait.stop()
	if prev == "Jump":
		prev = "Fall"
	if prev == "DJump":
		prev = "Fall2"
	state_machine.transition_to(prev)

# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_msg := {}) -> void:
#	player.get_node("animation").play("Jump")
	loop = false
	player.get_node("animation").play("cast")
	shoot()
	
	
func shoot():
	if ready:
		ready = false
		$Wait.start(0.3)
		$CD.start(0.3)

# Virtual function. Called by the state machine before changing the active state. Use this function
# to clean up the state.
func exit() -> void:
	pass


func _on_CD_timeout():
	ready = true


func _on_Wait_timeout():
	player.shoot() # Replace with function body.

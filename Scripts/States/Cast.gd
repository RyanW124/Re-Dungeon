extends "res://Scripts/States/State.gd"
class_name Cast
var loop = false
var ready_shoot = true

# Virtual function. Corresponds to the `_process()` callback.
func update(_delta: float) -> void:
	shoot()
	if not player.is_on_floor():
		player.move(_delta)
		player.update_anim()
	
	player.get_node("animation").play("cast-loop" if loop else "cast")
	if loop and not Input.is_action_pressed("Shoot"):
		next()
	
	

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
	if ready_shoot:
		ready_shoot = false
		$Wait.start(0.3)
		$CD.start(0.3)
		

func _on_CD_timeout():
	ready_shoot = true


func _on_Wait_timeout():
	player.shoot() # Replace with function body.

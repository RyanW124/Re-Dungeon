extends "res://Scripts/Movable.gd"

onready var fsm = $FSM
var accel = 0
var a = 5
onready var buffer = $buffer

func spawn():
	return ($spawn if right else $spawn2).global_position
func shoot():
	var p = projectile.instance()
	p.init(Vector2.RIGHT if right else Vector2.LEFT, self, 1)
	get_tree().root.add_child(p)
	get_tree().root.move_child(p, 0)
func _ready():
	change_collide("Idle")
	$dirt.emitting = false
#	print(position)
func is_stuck():
	for i in [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]:
		
		if not test_move(transform, i):
			return false
	return true
func change_collide(type):
	var p:String = "d"
	for i in get_children():
		if i.name.ends_with("_collide"):
			i.disabled = not i.name.begins_with(type)
#func _process(delta):
#	print(position)
func move(delta, multi=1):
	if Input.is_action_pressed("Left") == Input.is_action_pressed("Right"):
		accel = 0
	else:
		if Input.is_action_pressed("Left"):
			accel -= speed *delta * a
		if Input.is_action_pressed("Right"):
			accel += speed*delta * a
	accel = clamp(accel, -speed, speed)
	vel.x = accel * multi
	
func die():
	$FSM.transition_to("Die")
#func _physics_process(delta):
#	print($animation.animation, $animation.frame)
	
#	if Input.is_action_just_pressed("Jump") and (is_on_floor() or is_on_wall()):
#		jump()
#	if Input.is_action_pressed("Left"):
#		vel.x -= speed
#	if Input.is_action_just_pressed("Shoot"):
#		shoot()
#	if Input.is_action_pressed("Right"):
#		vel.x += speed
#	._physics_process(delta)


#func _on_Player_tree_exiting():
#	print(2) # Replace with function body.

extends "res://Scripts/Movable.gd"

var accel = 0
var a = 5
var coins = 0
export(NodePath) var light
onready var buffer = $buffer
var health_stat = 0
var speed_stat = 0
var damage_stat = 0
var vision_stat = 0
var hitboxes = []
onready var cam = $Camera2D
export(String, FILE) var blood

func hp():
	return health_stat + 3
func damage():
	return damage_stat * 0.3 + 1
func vision():
	return vision_stat*.7+3
func speed():
	return 25 + 10 * speed_stat
func spawn():
	return ($spawn if right else $spawn2).global_position
func shoot():
	var p = projectile.instance()
	p.init(Vector2.RIGHT if right else Vector2.LEFT, self, damage())
	get_tree().root.add_child(p)
	get_tree().root.move_child(p, 0)
func update_anim():
	.update_anim()
	for j in hitboxes:
		j.position.x = abs(j.position.x)
		if not right: 
			j.position.x *= -1
func update_stats():
	$Light2D.texture_scale = vision()
	light.texture_scale = vision()
#	print(vision(), " ", vision_stat)
	max_health = hp()
	speed = speed()
	for j in hitboxes:
		j.damage = damage()
	
	health = max_health
func _ready():
#	print(vision())
	for i in get_children():
		if i is Area2D: hitboxes.append(i)
	light = get_node(light)
	blood = load(blood)
	fsm = $FSM
	Save.player = self
	coins = Save.coins
	update_stats()
	change_collide("Idle")
	$dirt.emitting = false
#	print(position)

func take_damage(dmg, pos=null, kb=null):
#	health -= dmg
	var b = blood.instance()
	b.global_position = $mid.global_position
	b.direction = pos
	get_parent().add_child(b)
	b.restart()
	if health <= 0:
		die()
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
func save():
	Save.coins = coins
	Save.damage = damage_stat
	Save.speed = speed_stat
	Save.health = health_stat
	Save.vision = vision_stat
	
	
func _process(delta):
	vel.x = 0
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

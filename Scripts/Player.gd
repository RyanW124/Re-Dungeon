extends "res://Scripts/Movable.gd"

var input_lock = false
var accel = 0
var a = 5
var coins = 0
var ammo_count
var hold = true
#export(NodePath) var light
onready var buffer = $buffer
var health_stat = 0
var speed_stat = 0
var damage_stat = 0
var vision_stat = 0
var jump_stat = 0
var ammo_stat = 0
var healthbar
var powerup = ""
onready var powert = $PowerT
var hitboxes = []
const light_path = "res://Assets/Light"
var combo = 0
export(NodePath) var portal
onready var mid = $mid
#onready var cam = $Camera2D
export(String, FILE) var blood

func ammo():
	return ammo_stat
func hp():
	return health_stat + 3
func damage():
	return damage_stat * 0.3 + 1
func vision():
	return vision_stat 
#	return vision_stat*4+18
func jumps():
	return jump_stat * 15 + 50
func speed():
	return 25 + 10 * speed_stat
func spawn():
	return ($spawn if right else $spawn2).global_position
func shoot():
	if ammo_count > 0:
		ammo_count -= 1
	else:
		return
	var p = projectile.instance()
	p.init(Vector2.RIGHT if right else Vector2.LEFT, self, damage())
	get_tree().root.get_node("Main").add_child(p)
	
#	get_tree().root.get_node("Main").move_child(p, 0)
func update_anim():
	.update_anim()
	for j in hitboxes:
		j.position.x = abs(j.position.x)
		if not right: 
			j.position.x *= -1
func update_stats():
	$Light2D.texture = load("%s/%s.png" % [light_path, vision()])
	$Light2D2.texture = load("%s/%s.png" % [light_path, vision()])
	$Light2D3.texture = load("%s/%s.png" % [light_path, vision()])
#	print(vision(), " ", vision_stat)
	max_health = hp()
	speed = speed()
	for j in hitboxes:
		j.damage = damage()
	ammo_count = ammo()
	jump_power = jumps()
	health = max_health
	if healthbar: healthbar.max_value = max_health
func _ready():
#	print(vision())
	for i in get_children():
		if i is Area2D: hitboxes.append(i)
	blood = load(blood)
	fsm = $FSM
	Save.player = self
	coins = Save.coins
	damage_stat = Save.damage
	vision_stat = Save.vision
	speed_stat = Save.speed
	health_stat = Save.health
	ammo_stat = Save.ammo
	jump_stat = Save.jump
	portal = get_node(portal)
	
	update_stats()
	change_collide("Idle")
	$dirt.emitting = false
#	print(position)

func take_damage(dmg, pos=null, kb=null):
	if dmg < 10000 and activeP() == "Immune": return
	health -= dmg
	health = max(health, 0)
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
func resolve():
	if is_stuck() or fsm.state.name in ["Crouch", "Slide"]:
		fsm.transition_to("Crouch")
	else:
		fsm.transition_to("Idle")
func end():
	ended = true
func move(delta, multi=1):
	if input_lock:
		return
	var d = 0
	if Input.is_action_pressed("Left") == Input.is_action_pressed("Right"):
		if Input.is_action_pressed("Left") and Input.is_action_pressed("Right"):
			if hold:
				d += speed*delta * a
			else:
				d -= speed*delta * a
		else:
			accel = 0
	else:
		if Input.is_action_pressed("Left"):
			d -= speed *delta * a
		if Input.is_action_pressed("Right"):
			d += speed*delta * a
	if accel != 0 and sign(accel) != sign(d):
		accel = 0
	else:
		accel += d
	accel = clamp(accel, -speed, speed)
	vel.x = accel * multi
func save():
	Save.coins = coins
	Save.damage = damage_stat
	Save.speed = speed_stat
	Save.health = health_stat
	Save.vision = vision_stat
	Save.ammo = ammo_stat
	Save.jump = jump_stat
	
	
func add_combo():
	combo += 1
	$Combo.text = "Combo\nx"+str(combo)	
	$Combo/anim.play("Add")
	
func _process(delta):
	$dirt.emitting = vel.x != 0 and is_on_floor()
	$dirt.direction.x = sign(vel.x) * -2
	$Combo.visible = combo > 0
	if Input.is_action_just_pressed("Power Up"):
		powerup()
	if Input.is_action_just_pressed("Right"):
		hold = true
	elif Input.is_action_just_pressed("Left"):
		hold = false
	if Input.is_action_just_pressed("Portal") and (ammo_count >= 2 or portal.active):
		ammo_count -= 2
		ammo_count = max(0, ammo_count)
		portal.act()
func activeP():
	return "" if powert.is_stopped() else powerup
func powerup():
	if !powerup: return
	var times = {"Cloak": 20, "Immune": 3}
	powert.start(times[powerup])
	Save.main.overlay.powerup(powerup, times[powerup])
func die():
	$FSM.transition_to("Die")


func _on_PowerT_timeout():
	powerup = ""
	Save.main.overlay.powerup()

extends KinematicBody2D
class_name Fly
onready var ray: RayCast2D = $ray
onready var pmid = Save.player.get_node("mid")
export var speed: float
export var _range: float
export var max_health: float
export var coins: int
var coineffect = preload("res://Scenes/CoinEffect.tscn")
onready var health: float = max_health
var off_multi = 0
var offset = Vector2.ZERO
onready var fsm = $FSM
export(String, FILE) var blood
func _ready():
	blood = load(blood)
	ray.add_exception(Save.player)
	$hitbox.damage = 2
	
func update_ray():
	ray.cast_to = ppos() - position
#	print(ray.is_colliding())
func _physics_process(delta):
	var vel = offset * off_multi
	off_multi = max(off_multi-delta*3, 0)
	vel = move_and_slide(vel, Vector2.UP)
func ppos():
	return pmid.global_position
func move():
	var vel = move_and_slide((ppos()-position).normalized()*speed)
	if vel.x == 0:
		return
	
	var right = vel.x > 0
	$animation.flip_h = not right
	$hitbox.position.x = abs($hitbox.position.x)
	if not right: 
		$hitbox.position.x *= -1
func hurt(dir:Vector2, kb=200):
	$animation.blink()
	off_multi = 1
	offset = kb * dir.normalized()
	var b = blood.instance()
	b.global_position = global_position
	b.direction = dir
	get_parent().add_child(b)
	b.restart()
func take_damage(dmg, pos, kb=200):
	fsm.transition_to("Hurt")
	hurt(pos, kb)
	health -= dmg
	Engine.time_scale = 0.07
	yield(get_tree().create_timer(0.02), "timeout")
	Engine.time_scale = 1
	if health <= 0:
		var c = coineffect.instance()
		get_parent().add_child(c)
		c.start(coins, position)
		queue_free()
func in_range():
	return position.distance_to(ppos()) < _range

func colliding():
	return Save.player in $hitbox.get_overlapping_bodies()

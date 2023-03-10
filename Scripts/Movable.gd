extends KinematicBody2D

export var gravity: float = 1
onready var og_gravity = gravity
export var jump_power: float = 500
export var speed: float
export var max_health: float
var health: float
var ended = false
export(String, FILE) var projectile_path = ""
var projectile: Resource
var off_multi = 0
var y_limit = 400
var attached = false
var offset = Vector2.ZERO
var right: bool = true
var fsm
var move_vel = Vector2.ZERO

var vel: Vector2 = Vector2.ZERO


func _ready():
	health = max_health
	projectile = load(projectile_path)
	$animation.play("idle")
	

func update_anim():
	if vel.x == 0:
		return
	
	right = vel.x > 0
	$animation.flip_h = not right
func djump():
	vel.y = -jump_power
	$animation.play("djump")
func jump():
	vel.y = -jump_power
	$animation.play("jump")

func hurt(dir:Vector2, kb=200):
	off_multi = 1
	offset = kb * dir.normalized()
	vel = Vector2.ZERO


func on_ladder():
	return touching_ladder() and attached
func touching_ladder():
	for i in get_tree().get_nodes_in_group("Ladder"):
		if self in i.get_overlapping_bodies():
			return true
	return false

func attach():
	if touching_ladder(): attached = true
func _physics_process(delta):
#	vel.x = 0
	if not touching_ladder(): attached = false
	vel.y += gravity if vel.y < 0 else gravity * 3
	vel += offset * off_multi
	if offset.y != 0:
		offset.y = 0
	off_multi = max(off_multi-delta*3, 0)
	if abs(vel.y) > y_limit: vel.y = y_limit * sign(vel.y)
	if ended:
		vel = Vector2.ZERO
	else:
		vel = move_and_slide(vel, Vector2.UP)
	move_vel = vel
	vel.x = 0	
#	if health <= 0:
#		queue_free()
#
	


extends Area2D

var speed: float = 300
var _range = 600
var direction: Vector2
var parent
var damage
var target = "Enemies"
var start: Vector2
var disabled = false

func _ready():
	$AnimatedSprite.play("default")

func init(dir: Vector2, p, dmg):
	direction = dir.normalized()
	global_position = p.spawn()
	start = position
	parent = p
	damage = dmg
	

func _process(delta):
	position += direction * speed * delta
	
	if position.distance_to(start) >= _range:
		queue_free()


func _on_Projectile_body_entered(body):
	if body == parent:
		return
	if body.is_in_group(target):
		body.take_damage(damage, direction)
	queue_free()

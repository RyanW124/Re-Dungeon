extends Area2D
class_name hitbox

@export var anim_name: String
@export var active # (Array, int)
@export var animation: NodePath
var anim
@export var target: String
var disabled = true
var cont = true
var prev = true
var hit = []
@export var dmgmulti: float = 1
@export var kbs = 200
var damage
@export var single:bool = true

func _ready():
	anim = get_node(animation)
#	damage = get_parent().damage()
	
func _process(delta):
	
	disabled = not (anim.animation == anim_name and anim.frame in active)
	if prev != disabled:
		cont = true
		hit = []
	prev = disabled
	if not cont:
		disabled = true
	if not disabled:
		for body in get_overlapping_bodies():
			if not body in hit and (body.is_in_group(target) or target == "" and (body.is_in_group("Enemies") or body.is_in_group("Player"))):
				hit(body)
#	print(disabled)

func hit(body):
	body.take_damage(damage*dmgmulti, kb(body), kbs)
	hit.append(body)
	if single: cont = false
func kb(body=null):
	return Vector2.RIGHT*sign(position.x)

#func _on_hitbox_body_entered(body):
#	if body.is_in_group(target) and not disabled:
#		print(3)
#		body.take_damage(damage, kb())
#		disabled = true


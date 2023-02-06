extends Area2D

export var anim_name: String
export(Array, int) var active
export var animation: NodePath
var anim
export var target: String
var disabled = true
var cont = true
var prev = true
var hit = []
export var dmgmulti: float = 1
export var kbs = 200
var damage
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
			if not body in hit and body.is_in_group(target):
				body.take_damage(damage*dmgmulti, kb(), kbs)
				hit.append(body)
				cont = false
#	print(disabled)

	
func kb():
	return Vector2.RIGHT*sign(position.x)

#func _on_hitbox_body_entered(body):
#	if body.is_in_group(target) and not disabled:
#		print(3)
#		body.take_damage(damage, kb())
#		disabled = true

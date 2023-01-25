extends Area2D

export var anim_name: String
export(Array, int) var active
export var animation: NodePath
var anim
export var target: String

var damage
func _ready():
	anim = get_node(animation)
	
func _process(delta):
	$CollisionShape2D.disabled = not (anim.animation == anim_name and anim.frame in active)
	


func _on_hitbox_body_entered(body):
	if body.is_in_group(target):
		body.take_damage(damage, Vector2.RIGHT*sign(position.x))
		$CollisionShape2D.disabled = true

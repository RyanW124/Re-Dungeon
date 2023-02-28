extends "res://Scripts/hitbox.gd"

func _ready():
	kbs = 200
func kb(body=null):
	return Vector2.UP
func hit(body):
	body.take_damage(damage*dmgmulti, kb(body), kbs*int(body is Fly or body.vel.y <= 0))
	hit.append(body)
	if single: cont = false

extends "res://Scripts/States/State.gd"

var a
var a2
var hitbox


func _ready():
	name = "Attack"
	
func play():
	a.play("cast")
	a2.play("shoot")
	
func anim_update():
	state_machine.transition_to("Idle")

func update(_delta):
	play()
	
func enter(msg=null):
#	print(1)
	if a == null:
		a = player.get_node("animation")
		a2 = player.get_node("animation2")
		hitbox = player.get_node("hitbox")
	play()
	a2.show()
	a2.play("shoot")
	a2.frame = 0
	a2.position.x = abs(a2.position.x)
	hitbox.position.x = abs(hitbox.position.x)
	player.vel.x = 0
	
	if player.position.x > Save.player.position.x:
		a2.position.x *= -1
		hitbox.position.x *= -1
		a2.flip_h = true
		a.flip_h = true
	else:
		a2.flip_h = false
		a.flip_h = false
		
func exit():
	a2.hide()
#	a2.stop()
		

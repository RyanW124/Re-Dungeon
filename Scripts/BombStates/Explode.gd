extends State

onready var a1
onready var a2



func take_damage(dmg, pos, kb):
	pass
	
func anim_update():
	player.queue_free()
func enter(msg=null):
	a1 = player.get_node("animation")
	a2 = player.get_node("Explode")
	a1.hide()
	a2.show()
	a2.play("explode")

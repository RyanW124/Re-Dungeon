extends "res://Scripts/States/State.gd"


func _ready():
	name = "Attack"
	
func update(_delta):
	player.get_node("animation").play("attack")
	
func anim_update():
#	print(4)
	state_machine.transition_to(prev)
	
func enter(msg=null):
#	print(3)
	player.get_node("animation").play("attack")

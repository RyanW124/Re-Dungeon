extends "res://Scripts/States/State.gd"
class_name Die

var tilemap: TileMap
export(String, FILE) var start

# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(msg=null):
	player.get_node("animation").play('die')

func anim_update():
	player.save()
	Save.main.die()

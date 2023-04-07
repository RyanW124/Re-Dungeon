extends "res://Scripts/States/State.gd"


var count = 0
var dir = -1

func _ready():
	name = "Idle"

func update(_delta):
	player.get_node("RayCast2D").cast_to = Save.player.get_node("mid").global_position - player.get_node("RayCast2D").global_position	
	player.get_node("animation").play("idle")	
	if Save.player.activeP() != "Cloak" and Save.player in player.get_node("Activation").get_overlapping_bodies() and not player.get_node("RayCast2D").is_colliding():
		state_machine.transition_to("Attack")
		if count > 1:
			player.get_node("Alert").alert()
		return
	if not player.is_on_floor():
		return
	player.vel.x = dir*player.speed
	player.update_anim()
	var cell = player.tiles.v_to_cell(player.position)
	count += _delta
	cell.x += dir
#	print(player.get_node("RayCast2D").is_colliding(),player.get_node("RayCast2D").cast_to)
	
			
	if player.tiles.graph.get(cell, 1) != 0:
		dir *= -1
	

func enter(msg=null):
	player.get_node("animation").play("idle")
	count = 0



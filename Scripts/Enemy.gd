extends "res://Scripts/Movable.gd"

var tiles: TileMap
var dir = 1
func _ready():
	tiles = get_parent().get_node("TileMap")
	
func take_damage(dmg, pos):
	fsm.transition_to("Hurt")
	hurt(pos)
	health -= dmg
	Engine.time_scale = 0.07
	yield(get_tree().create_timer(0.02), "timeout")
	Engine.time_scale = 1
	if health <= 0:
		queue_free()
func _physics_process(delta):
	pass
#	var distance = tiles.a_star()
	
	
#func _physics_process(delta):
#	$animation.play("walk")
#	update_anim()
#	var x = floor((position.x-tiles.position.x)/tiles.cell_size.x/tiles.scale.x)+dir
#	var y = floor((position.y-tiles.position.y+140)/tiles.cell_size.y/tiles.scale.y)-1
#	if tiles.get_cell(x, y) == -1 or vel.x == 0:
#		dir *= -1
#	vel.x = speed*dir
#	move_and_slide(speed*dir*Vector2.RIGHT)

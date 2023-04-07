extends "res://Scripts/Movable.gd"

var tiles: TileMap
var dir = 1
export var coins: int
var h = true
export(String, FILE) var blood
var coineffect = preload("res://Scenes/CoinEffect.tscn")
func _ready():
	tiles = get_parent().get_node("TileMap")
	blood = load(blood)
	fsm = $FSM
	
func take_damage(dmg, pos, kb=200):
#	print(dmg)
	if h: fsm.transition_to("Hurt")
	hurt(pos, kb)
	health -= dmg
	Engine.time_scale = 0.07
	yield(get_tree().create_timer(0.02), "timeout")
	Engine.time_scale = 1
	if health <= 0:
		Save.enemy_count -= 1
		var c = coineffect.instance()
		get_parent().add_child(c)
		c.start(coins, $mid.global_position)
		queue_free()
func _physics_process(delta):
	pass
#	var distance = tiles.a_star()
func alert():
	$Alert.alert()
	
func hurt(dir:Vector2, kb=200):
	$animation.blink()
	.hurt(dir, kb)
	var b = blood.instance()
	b.global_position = $mid.global_position
	b.direction = dir
	get_parent().add_child(b)
	b.restart()
#func _physics_process(delta):
#	$animation.play("walk")
#	update_anim()
#	var x = floor((position.x-tiles.position.x)/tiles.cell_size.x/tiles.scale.x)+dir
#	var y = floor((position.y-tiles.position.y+140)/tiles.cell_size.y/tiles.scale.y)-1
#	if tiles.get_cell(x, y) == -1 or vel.x == 0:
#		dir *= -1
#	vel.x = speed*dir
#	move_and_slide(speed*dir*Vector2.RIGHT)

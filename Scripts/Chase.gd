extends "res://Scripts/Enemy.gd"

var passed = true
var prev = 0
var alert = false
var dist

var d = Vector2.ZERO
func _ready():
	fsm = $EnemyFSM
	$EnemyFSM.transition_to("Idle")
	$hitbox.damage = 1
func damage():
	return 1

func update_anim():
	.update_anim()
	
func side():
#	print(int(position.x if d.y == 0 else position.y)%16)
#	print(fposmod(position.x if d.y == 0 else position.y, 16))
	return fposmod(position.x if d.y == 0 else position.y, 16)
func has_pos():
	var pos = tiles.v_to_cell(position)
	return tiles.graph.has(pos)
func get_distance(delta=Vector2.ZERO):
	var pos = tiles.v_to_cell(position)
	var distance = tiles.a_star()
	return distance.get(pos+delta, INF)
func alert():
	if not alert:
		alert = true
		$Alert.alert()
func _physics_process(delta):
	pass
#	dist = distance.get(pos, INF)
	
	
		
#		tiles.pastar()
	

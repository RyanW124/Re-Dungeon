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
func get_d():
	var s = side()
	if (prev < 8) != (s < 8) and (prev < 1) == (s < 1):
		passed = true
#	print(passed)
	prev = s
	if passed:
		d = Vector2.ZERO
		if 1<get_distance() and get_distance()< 20:
			d = Vector2.ZERO
			
			for i in [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]:
				if get_distance(i) == get_distance() -1:
	#				fsm.direction = i
					d = i
					alert()
					passed = false
					break
		else:
			alert = not has_pos()
	return d
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
	if not alert and Save.player.activeP() != "Cloak":
		alert = true
		$Alert.alert()
func _physics_process(delta):
	pass
#	dist = distance.get(pos, INF)
	
	
		
#		tiles.pastar()
	

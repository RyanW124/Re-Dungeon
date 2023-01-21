extends "res://Scripts/Enemy.gd"

var passed = true
var prev = 0
var alert = false
var d = Vector2.ZERO
func _ready():
	fsm = $EnemyFSM
	
	$EnemyFSM.transition_to("Idle")
	
func side():
#	print(int(position.x if d.y == 0 else position.y)%16)
#	print(fposmod(position.x if d.y == 0 else position.y, 16))
	return fposmod(position.x if d.y == 0 else position.y, 16)
func _physics_process(delta):
	var pos = tiles.v_to_cell(position)
	var distance = tiles.a_star()
	var s = side()
	if (prev < 8) != (s < 8) and (prev < 1) == (s < 1):
		passed = true
#	print(passed)
	prev = s
	if passed:
		d = Vector2.ZERO
		if distance.get(pos, INF) < 20:
			if not alert:
				alert = true
				$Alert.alert()
			for i in [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]:
				if distance.get(pos+i, INF) == distance.get(pos, INF) -1:
					fsm.direction = i
					d = i
					passed = false
		else:
			alert = not tiles.graph.has(pos)
			
#	print(tiles.graph.get(pos, 0))

	if d == Vector2.ZERO:
		vel.x = 0	
	elif d.x != 0:
		vel.y += speed*d.y
		vel.x = speed*d.x
	elif d.y < 0 and is_on_floor():
#		print(d.y)
		jump()
		
#		tiles.pastar()
	

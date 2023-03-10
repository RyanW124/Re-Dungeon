extends TileMap

export(String, FILE) var kill
export(String, FILE) var breakable
export(String, FILE) var unbreakable
export(String, FILE) var ladder
export(String, FILE) var halfladder
onready var explode = preload("res://Particle/explode.tscn")
var ending = false
var speed = 50
onready var start = get_used_rect().position
onready var end = get_used_rect().end
var dir = 1
# 0 = walk, 1 = corner to left, 2 = corner to right, 3 = fall, 4 = death
var graph = {}
onready var pos = start
var list = [[20, 14, 16], [15, 21], [2], [17], [22]]
var dict = {}
var index: float = 0
var to_del = []
var jumph = 4
var obj
var prev_pos
var prev_dist = {}
var test = {}
onready var player = get_parent().get_node("Player")

func _ready():
	for i in range(len(list)):
		for j in list[i]: dict[j] = i
	obj = {0: breakable, 1:unbreakable, 2: kill, 3: ladder, 4: halfladder}
	# breakable = 20, grass = 14, Ladder = 17, Liquid = 18, Steel = 15, 
	# Vine = 19, Wood = 16, unbreakable = 21
	for i in obj:
		obj[i] = load(obj[i])
		for j in get_cell_of_type(i):
			var p = obj[i].instance()
			p.tilemap = self
			p.global_position = cell_to_v(j)
			add_child(p)
#	for i in range(100000):
#		test[i] = i
	make_graph()
#func _process(delta):
#	test.has(99999)
func fill(temp, i, d):
	var j = 1
	while not graph.has(i+Vector2(d, j)) and get_cell(i.x+d, i.y+j) == -1:
#		print(j)
		if not graph.get(i+Vector2(d, j), 0) in [1, 2]:
			temp[i+Vector2(d, j)] = 3
		j += 1
	if j < jumph and get_cell(i.x+d, i.y+j) == -1:
		temp[i+Vector2(d, j)] = 4
func corg(v):
#	print(v,graph.has(v), get_cell(v.x, v.y) != -1)
	return graph.has(v) or get_cell(v.x, v.y) != -1
func check_above(cell, d = 2):
	for i in range(1, d+1):
		if get_cell(cell.x, cell.y-i) != -1:
			return false
	return true
func make_graph():
	prev_pos = null
	graph = {}
	for i in get_cell_of_type(0)+get_cell_of_type(1):
		var above = Vector2(i[0], i[1]-1)
		if check_above(i):
			graph[above] = 0
	var temp = {}
	for i in graph:
		if not corg(i+Vector2.LEFT) and check_above(i+Vector2.LEFT):
			temp[i+Vector2.LEFT] = 1
			fill(temp, i, -1)
		if not corg(i+Vector2.RIGHT) and check_above(i+Vector2.RIGHT):
			temp[i+Vector2.RIGHT] = 2
			fill(temp, i, 1)
		
	for i in temp:
		graph[i] = temp[i]
	
	for i in get_cell_of_type(2):
		var above = Vector2(i[0], i[1]-1)
		if get_cell(above.x, above.y) == -1:
			graph[above] = 5
#	for j in range(-12, 1):
#		var t = ""
#		for i in range(-1, 19):
#			t += str(graph.get(Vector2(i, j), " "))
#		print(t)
#	print()
func get_cell_of_type(n):
	var ret = []
	for i in list[n]:
		ret += get_used_cells_by_id(i)
	return ret
		
func a_star():
	var pos = v_to_cell(player.position)
	if not pos in graph:
		pos = prev_pos
	if prev_pos == pos:
		return prev_dist
	prev_pos = pos	
	var visited = {}
	var distance = {}
	for i in graph:
		visited[i] = false
	visited[pos] = true
	var queue = [pos]
	distance[pos] = 0
	while not queue.empty():
		pos = min_arr(queue, distance)
		queue.erase(pos)
		var d = distance[pos] + 1
#		if d > 10:
#			continue
		var adj = [Vector2.LEFT, Vector2.UP, Vector2.DOWN, Vector2.RIGHT]
		if graph[pos] == 3:
			adj = [Vector2.UP, Vector2.DOWN]
		elif graph[pos] == 1:
			adj = [Vector2.RIGHT, Vector2.DOWN]
		elif graph[pos] == 2:
			adj = [Vector2.LEFT, Vector2.DOWN]
		elif graph[pos] == 0:
			adj = [Vector2.LEFT, Vector2.RIGHT, Vector2.UP]
		for delta in adj:
			if delta == Vector2.DOWN:
				var j = 1
				while graph.has(pos+Vector2(0, j)):
					if graph[pos+Vector2(0, j)] == 4:
						if j <= jumph:
							var npos = pos + delta
							visited[npos] = true
							queue.append(npos)
				#			print(d)
							distance[npos] = min(distance.get(npos, INF), d)
						break
					elif j > jumph:
						break
					j+=1
				continue
			if not graph.has(pos+delta):
				continue
			var npos = pos + delta
			if graph[npos] == 5 or visited[npos]:
				continue
			visited[npos] = true
			queue.append(npos)
#			print(d)
			distance[npos] = min(distance.get(npos, INF), d)
	prev_dist = distance
	return distance
func pastar():
	var distance = a_star()
	for j in range(-12, 1):
		var t = ""
		for i in range(-1, 19):
			var x = str(distance.get(Vector2(i, j), " "))[-1]
			if x == "inf":
				x = "i"
			t += x
		print(t)
	print()
func cell_to_v(x, y=null):
	if y == null:
		y = x[1]
		x = x[0]
	return cell_size.x * Vector2(x, y)
func v_to_cell(x, y=null):
	if y == null:
		y = x.y
		x = x.x
	return Vector2(floor(x/cell_size.x), floor(y/cell_size.x))
func min_arr(arr, dict):
	var v = arr[0]
	var m = dict[v]
	
	for i in arr:
		if dict[i] < m:
			m = dict[i]
			v = i
	return v
	
func _process(delta):
	if not ending:
		return
	var newindex = index + delta * speed * dir
	if newindex >= len(to_del):
		newindex = len(to_del)
		ending = false
		get_parent().transition()
	for i in range(index, newindex):
		var e = explode.instance()
		e.position = cell_to_v(to_del[i]) + Vector2(8, 8)
		get_parent().add_child(e)
		e.restart()
		set_cell(to_del[i].x, to_del[i].y, -1)
	index = newindex
func end():
	ending = true
	to_del = get_used_cells()

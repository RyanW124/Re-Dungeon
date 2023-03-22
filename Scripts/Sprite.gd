extends Node2D

@onready var size = $Sprite2D.texture.get_size()
var dirs = [-1, 0, 1]
var offset = Vector2.ZERO
var nodes = []
func _ready():
#	print(position)
	Save.reset()
	
	for i in dirs:
		for j in dirs:
			if i == 0 and 0 == j:
				continue
			var p = $Sprite2D.duplicate()
			p.position += Vector2(i*size.x, j*size.y)
			nodes.append(dirs)
			add_child(p)
	
func _process(delta):
	position += Save.cam.vel / 2
	offset += Save.cam.vel / 2
	if abs(offset.x) >= size.x:
		position.x += sign(offset.x) * size.x
		offset.x = 0
	if abs(offset.y) >= size.y:
		position.y += sign(offset.y) * size.y
		offset.y = 0
		

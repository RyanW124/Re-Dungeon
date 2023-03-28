extends Label

onready var og = rect_size
func _ready():
	pass

func display(t):
	text = t
	while get_line_count()>5: 
		rect_size.x += 50
		rect_size.y = og.y
	rect_position = get_viewport().get_mouse_position()
	show()
	
func hide():
	.hide()
	rect_size=og
#	print(rect_position)

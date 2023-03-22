extends TextureProgressBar

var green = preload("res://Assets/GUI/barHorizontal_green.png")
var yellow = preload("res://Assets/GUI/barHorizontal_yellow.png")
var red = preload("res://Assets/GUI/barHorizontal_red.png")
@export var parent: NodePath

func _ready():
	ready()
func ready():
	parent = get_node(parent)
	hide()
	max_value = parent.max_health
func _process(delta):
	value = parent.health
	texture_progress = green
	if value < max_value * 0.7:
		texture_progress = yellow
	elif value < max_value * 0.35:
		texture_progress = red
	else:
		texture_progress = green
	if value < max_value:
		 show()

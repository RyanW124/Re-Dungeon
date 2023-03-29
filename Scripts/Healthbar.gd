extends TextureProgress

var green = preload("res://Assets/GUI/barHorizontal_green.png")
var yellow = preload("res://Assets/GUI/barHorizontal_yellow.png")
var red = preload("res://Assets/GUI/barHorizontal_red.png")
export(NodePath) var parent
var prev
#var tween
onready var tween = $Tween

func _ready():
	ready()
#	tween = create_tween().bind_node(self).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
func ready():
	parent = get_node(parent)
	hide()
	prev = parent.health
	max_value = parent.max_health
func _process(delta):
#	if prev != parent.health:
#		tween.interpolate_property(self, "value", 
#			value, parent.health, 0.8,
#			Tween.TRANS_LINEAR, Tween.EASE_OUT)
#		tween.start()
#	prev = parent.health
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

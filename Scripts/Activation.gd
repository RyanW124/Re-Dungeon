extends Area2D

export var _name: String
signal collide(_name)
var active = true

func _ready():
	connect("collide", get_parent(), "_on_activation")


func _on_Jump_body_entered(body):
	if body.is_in_group("Player") and active:
		emit_signal("collide", _name)
#		active = false
		

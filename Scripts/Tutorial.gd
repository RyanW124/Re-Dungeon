extends "res://Scripts/Main.gd"


func _ready():
	pass
#	dialogue.display("")

func _on_activation(_name):
	fsm.on_act(_name)
#func _process(delta):
##	$StaticBody2D/CollisionShape2D
#	print($StaticBody2D/CollisionShape2D.disabled)

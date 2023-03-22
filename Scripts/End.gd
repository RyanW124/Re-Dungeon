extends Area2D

signal finish
func _ready():
	connect("finish", Callable(Save.main, "_on_finish"))
	$AnimatedSprite2D.play("default")
	


func _on_End_body_entered(body):
	if body.is_in_group("Player"):
		emit_signal("finish")

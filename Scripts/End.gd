extends Area2D

signal finish
func _ready():
	connect("finish", Save.main, "_on_finish")
	$AnimatedSprite.play("default")
	


func _on_End_body_entered(body):
	if body.is_in_group("Player"):
		emit_signal("finish")

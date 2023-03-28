extends Area2D

var touching := false
var powered := false

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("Power Up") and !powered and touching:
		powered = true
		queue_free()
		Save.main.powerup.show()		

func _on_PowerArea_body_entered(body):
	if body.is_in_group("Player"):
		touching = true
		
func _on_PowerArea_body_exited(body):
	if body.is_in_group("Player"):
		touching = false

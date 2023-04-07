extends Area2D

var active = false

signal finish
func _ready():
	connect("finish", Save.main, "_on_finish")
	$AnimatedSprite.play("default")
	$AnimationPlayer.play("RESET")
	

func activate():
	active = true
	$AnimationPlayer.play("activate")
	Save.main.cut_to(position, 3, 1.5)
	

func _on_End_body_entered(body):
	if body.is_in_group("Player") and active:
		emit_signal("finish")
func _process(delta):
	
	$Label.text = "Mobs Left: %s" % Save.enemy_count
	if Save.enemy_count <= 0 and !active:
		print("End", Save.enemy_count)
		activate()

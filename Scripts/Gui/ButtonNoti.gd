extends Control


func _ready():
	hide()

func play(key):
	$Label.text = "Press " + key
	$AnimationPlayer.play("press")
	show()

func hide():
	.hide()
	$AnimationPlayer.stop(true)

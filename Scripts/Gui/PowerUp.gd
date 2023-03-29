extends NinePatchRect

onready var anim = $AnimationPlayer

func _ready():
	anim.play("RESET")

func show():
	Save.update("powerup", true)	
	anim.play("open")	
	.show()
	yield(anim, "animation_finished")
	print($GridContainer.rect_size)

func hide():
	anim.play_backwards("open")
	yield(anim, "animation_finished")
	Save.update("powerup", false)
	.hide()

func _on_pressed(action):
	Save.player.powerup = action
	Save.main.overlay.powerup(action)
	hide()
	

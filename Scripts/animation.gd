extends AnimatedSprite


func _ready():
	pass

func blink(t=0.2):
	modulate = Color(1,1,1,.5)
	$Timer.start(t)

func _on_Timer_timeout():
	modulate = Color(1,1,1,1)

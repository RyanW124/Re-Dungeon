extends AnimatedSprite2D

var dir = -3
var flashing = false
func _ready():
	pass
	
func _process(delta):
	if flashing:
		modulate.a += delta * dir
		if modulate.a <= .5 or modulate.a >= 1:
			modulate.a = clamp(modulate.a, .5, 1)
			dir *= -1
			
func flash():
	if flashing: modulate.a = 1
	flashing = !flashing
	

func blink(t=0.2):
	modulate.a = 0.5
	$Timer.start(t)

func _on_Timer_timeout():
	modulate.a = 1

extends AnimatedSprite

var active = false
var og_scale

func _ready():
	play("default")
	og_scale = scale
	scale = Vector2.ZERO
func act():
	if active:
		Save.player.position = position - Save.player.mid.global_position + Save.player.position
	else:
		scale = og_scale
		position = Save.player.mid.global_position
	active = not active
	scale = og_scale * int(active)
	
func _process(delta):
	if active:
		scale -= Vector2.ONE * delta / 10
		if scale.x <= 0:
			act()
			

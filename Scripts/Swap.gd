extends Projectile


func _ready():
	pass
func _process(delta):
	direction = 	(Save.player.mid.global_position - position).normalized()
func hit(body):
	Save.cam.turn(5)
	print(1)
	super.hit(body)

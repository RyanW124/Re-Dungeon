extends CPUParticles2D

export var c: Color

func _ready():
	pass
#	$Timer.start(lifetime)


func _on_Timer_timeout():
	queue_free()

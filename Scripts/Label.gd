extends Label

var forward = true

func _ready():
	play()

func play():
	if forward: $AnimationPlayer.play("Flash")
	else: $AnimationPlayer.play_backwards("Flash")
	forward = !forward
	$p1.restart()
	$p2.restart()
	


func _on_AnimationPlayer_animation_finished(anim_name):
	play()

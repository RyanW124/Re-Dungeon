extends Node2D


func _ready():
	pass

func start(coins, pos):
	position = pos
	Save.player.coins += coins
	$Label.text = "+%s" % coins
	$AnimationPlayer.play("anim")
	yield($AnimationPlayer, "animation_finished")
	queue_free()

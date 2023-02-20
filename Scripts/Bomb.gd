extends "res://Scripts/Movable.gd"


func _ready():
	fsm = $FSM
	$Explode.hide()
	$Explode.frame = 0
	$hitbox.damage = 10

func take_damage(dmg, pos, kb=200):
	fsm.state.take_damage(dmg, pos, kb)

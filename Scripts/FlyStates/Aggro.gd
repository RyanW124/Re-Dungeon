extends "res://Scripts/States/State.gd"

var state = 0

func _ready():
	name = "Aggro"


func update(_delta):
#	var d = player.position.distance_to(player.pmid.position)
	if player.ray.is_colliding() or not player.in_range():
		state_machine.transition_to("Idle")
	elif player.colliding():
		state_machine.transition_to("Attack")
		
	player.get_node("animation").play("flight")
	player.move()
	player.update_ray()
	



func enter(msg=null):
	player.get_node("animation").play("flight")
	if prev == "Idle":
		player.get_node("Alert").alert()


#func _on_hitbox_body_entered(body):
#	if body == Save.player: state_machine.transition_to("Attack")

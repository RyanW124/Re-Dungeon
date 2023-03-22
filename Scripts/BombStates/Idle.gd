extends State


func _ready():
	pass
func take_damage(dmg, pos, kb):
	player.health -= dmg
	Engine.time_scale = 0.07
	player.get_node("animation").blink()
	await get_tree().create_timer(0.02).timeout
	Engine.time_scale = 1
	if player.health <= 0:
		state_machine.transition_to("Exploding")

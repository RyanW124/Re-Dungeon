extends State

var prev_hit = true

func _ready():
	name = "Idle"

func attack():
	$Timer.start(5)
	state_machine.transition_to("Attack")
	
func update(_delta):
	player.get_node("animation").play("idle")
	player.update_ray()
	player.get_node("animation").flip_h = player.position.x < Save.player.position.x
	var hit = player.ray.is_colliding()
	if not hit:
		if prev_hit:
			player.alert()
		if $Timer.is_stopped():
			attack()
	prev_hit = hit
	
	

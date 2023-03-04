extends State
class_name Ladder
var speed
var actions = ["Jump", "Left", "Right", "Slide"]
var dirs = [Vector2.UP, Vector2.LEFT, Vector2.RIGHT, Vector2.DOWN]

func _ready():
	pass

func update(_delta):
	player.vel = Vector2.ZERO
	if Input.is_action_just_pressed("Ladder") or not player.on_ladder():
		state_machine.transition_to("Jump" 
			if Input.is_action_pressed("Jump") else "Idle")
		return
	var play = false
	for i in range(len(actions)):
		if Input.is_action_pressed(actions[i]):
			player.vel += dirs[i] * speed
			play = true
	if play:
		player.get_node("animation").play("ladder")
	else:
		player.get_node("animation").stop()
		
func enter(msg := {}):
	player.gravity = 0
	player.get_node("animation").play("ladder")
	player.attached = true
	speed = player.speed/3

func exit():
	player.gravity = player.og_gravity
	player.attached = false

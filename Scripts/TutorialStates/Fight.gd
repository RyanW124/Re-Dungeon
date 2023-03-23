extends TutState

var state = 0
onready var cam = $Camera2D
export(NodePath) var arrow
export(NodePath) var noti

var texts = ["Press %s to perform a normal attack" % Save.get_key("Attack1"),
			"Press %s to perform a heavy attack\nHolding a heavy attack on the ground increases damage" % Save.get_key("Heavy"),
			"Press %s to cast a projectile\nCasting a projectile consumes mana" % Save.get_key("Shoot"),
			"Use what you learnt do defeat the enemy"]
var texts2 = [Save.get_key("Attack1"),
			Save.get_key("Heavy"),
			Save.get_key("Shoot")]
func _ready():
	name = "Fight"
	arrow = get_node(arrow)
	noti = get_node(noti)
#	set_border(false)

func display():
	if state == 4:
		arrow.show()
	if state == 5:
		arrow.hide()
	if state % 2 == 1 and state / 2 < len(texts2):
		noti.play(texts2[(state-1)/2])
	if state % 2 == 0 and state / 2 < len(texts):
		noti.hide()
		player.dialogue.display(texts[state/2])
		state += 1
	
	
func on_d_closed():
	display()
	
	
func on_act(name):
	if state == 7 and name == "Climb":
		state_machine.transition_to("Climb")
	

func on_tran(prev, new):
	if prev in ["AirAttack", "Attack1", "Attack2"] and state == 1:
		state += 1
		display()
	elif prev in ["HeavyAir", "Heavy"] and state == 3:
		state += 1
		display()
	elif prev in ["Cast"] and state == 5:
		state += 1
		display()
		arrow.hide()
		Save.player.input_lock = false
		
#func set_border(active):
#	border1.set_disabled(!active)
#	border2.set_disabled(!active)
#func update(_delta):
#	print(border1.disabled)

	
func enter(msg := {}):
	state = 0
	Save.player.input_lock = true
	Save.update("cutscene", true)
	cam.position = Save.cam.position
	cam.make_current()
	cam.detach = $pos.position
	$Timer.start(1.5)
	yield($Timer, "timeout")
	cam.detach = null
	$Timer.start(1.5)
	yield($Timer, "timeout")
	Save.update("cutscene", false)
	Save.cam.make_current()
	player.dialogue.display("An enemy!\nLet's learn how to combat")

extends Node
var upgrading = true
var dialogue = false
var paused = false
var cutscene = false
var health = 10
var speed = 10
var damage = 10
var coins = 10
var vision = 5
var ammo = 100
var player
var cam
var main
#func _ready():
#	reset()
#	get_tree().connect("node_added", self, "reset")
func reset():
	player = get_tree().root.get_node("Main").get_node("Player")
	cam = get_tree().root.get_node("Main").get_node("Camera2D")
	main = get_tree().root.get_node("Main")
	cam.make_current()
func get_key(action):
	return InputMap.get_action_list(action)[0].as_text()
func update(property, value):
	set(property, value)
	get_tree().paused = upgrading or dialogue or paused or cutscene

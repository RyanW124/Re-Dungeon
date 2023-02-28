extends Node

var health = 10
var speed = 10
var damage = 10
var coins = 10
var vision = 10
var ammo = 100
onready var player = get_tree().root.get_node("Main").get_node("Player")
onready var cam = get_tree().root.get_node("Main").get_node("Camera2D")
onready var main = get_tree().root.get_node("Main")
func _ready():
	pass
func _process(delta):
	player = get_tree().root.get_node("Main").get_node("Player")
	cam = get_tree().root.get_node("Main").get_node("Camera2D")
	main = get_tree().root.get_node("Main")

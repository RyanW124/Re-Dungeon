extends Control

onready var player = get_tree().root.get_child(1).get_node("Player")
export(NodePath) var coinlabel 
func _ready():
	coinlabel = get_node(coinlabel)
	
func _process(delta):
	coinlabel.text = str(player.coins)
	

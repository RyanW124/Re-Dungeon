extends Control

onready var player = get_tree().root.get_child(1).get_node("Player")
export(NodePath) var coinlabel 
export(NodePath) var ammolabel 

func _ready():
	coinlabel = get_node(coinlabel)
	ammolabel = get_node(ammolabel)
	show()
	
	
func _process(delta):
	coinlabel.text = str(player.coins)
	ammolabel.text = str(player.ammo_count)
		

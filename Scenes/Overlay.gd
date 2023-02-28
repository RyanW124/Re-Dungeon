extends Control

onready var player = Save.player
export(NodePath) var coinlabel 
export(NodePath) var ammolabel 

func _ready():
	coinlabel = get_node(coinlabel)
	ammolabel = get_node(ammolabel)
	show()
	
	
func _process(delta):
	coinlabel.text = str(player.coins)
	ammolabel.text = str(player.ammo_count)
		

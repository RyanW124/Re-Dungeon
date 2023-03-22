extends Control

@onready var player = Save.player
@export var coinlabel: NodePath 
@export var ammolabel: NodePath 

func _ready():
	coinlabel = get_node(coinlabel)
	ammolabel = get_node(ammolabel)
	show()
	
	
func _process(delta):
	coinlabel.text = str(player.coins)
	ammolabel.text = str(player.ammo_count)
		

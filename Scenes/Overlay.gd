extends Control

onready var player = Save.player
export(NodePath) var coinlabel 
export(NodePath) var ammolabel 

func _ready():
	coinlabel = get_node(coinlabel)
	ammolabel = get_node(ammolabel)
	powerup()
	show()
	
	
func _process(delta):
	coinlabel.text = str(player.coins)
	ammolabel.text = str(player.ammo_count)
	$HBoxContainer/Progress.value = Save.player.powert.time_left
	
func powerup(text=null, duration=null):
	$HBoxContainer.visible = text != null
	if text == null:
		return
	$HBoxContainer/Progress.visible = duration != null
	$HBoxContainer/Label.text = text
	if !duration:
		$HBoxContainer/Label.text += " (Press %s to use)" % Save.get_key("Power Up")
		return
	$HBoxContainer/Progress.max_value = duration
	$HBoxContainer/Progress.value = $HBoxContainer/Progress.max_value

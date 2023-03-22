extends Control

@export var property: String
@export var texture: Texture2D
@onready var player = Save.player
func _ready():
	$Button.text = str(player.get(property))
	$Button.icon = texture


func _on_Button_pressed():
	if player.coins > 0 and player.get(property) < 10:
		player.coins -= 1
#		print(player.vision_stat)
		player.set(property, player.get(property)+1)
		$Button.text = str(player.get(property))
		

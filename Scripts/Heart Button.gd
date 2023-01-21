extends Control

export var property: String
export var texture: Texture
onready var player = get_tree().root.get_child(1).get_node("Player")
func _ready():
	$Button.text = str(player.get(property))
	$Button.icon = texture


func _on_Button_pressed():
	if player.coins > 0:
		player.coins -= 1
		player.set(property, player.get(property)+1)
		$Button.text = str(player.get(property))
		
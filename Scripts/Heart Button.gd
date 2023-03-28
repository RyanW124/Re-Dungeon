extends Control

export var property: String
export var property_name: String

export var texture: Texture
onready var player = Save.player
var hover = false
func _ready():
	$Button.text = str(player.get(property))
	$Button.icon = texture


func _on_Button_pressed():
	if player.coins > 0 and player.get(property) < 10:
		player.coins -= 1
#		print(player.vision_stat)
		player.set(property, player.get(property)+1)
		$Button.text = str(player.get(property))
		

func _input(event):
	if event is InputEventMouseMotion and hover:
		$Timer.start(1)
		yield($Timer, "timeout")
		if hover:
			hover = false
			Save.main.hint.display(property_name)

func _on_Button_mouse_entered():
	hover = true
	

func _on_Button_mouse_exited():
	hover = false
	Save.main.hint.hide()
	

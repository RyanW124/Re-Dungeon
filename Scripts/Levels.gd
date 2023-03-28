extends Control

onready var button = preload("res://Scenes/Gui/CenterButton.tscn")
var buttons = []
const level_path = "res://Scenes/Levels/%s.tscn"
export var count: int

func _ready():
	for i in range(count):
		var b = button.instance()
		b.change_name(str(i+1))
		b.connect("custom", self, "_on_pressed")
		$GridContainer.add_child(b)

func _on_pressed(level):
	level = int(level) - 1
	Save.bigreset(level == 0)
	get_tree().change_scene(level_path%level)

func _on_Button_pressed():
	hide()

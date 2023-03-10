extends Control

#var controls = ["Jump", "Shoot", "Attack1", "Slide", "Shoot", "Heavy",
#				"Portal", "Pause"]
var data = {}
var keys = {}
var buttons = {}
onready var textnode = preload("res://Scenes/Gui/CenterText.tscn")
onready var buttonnode = preload("res://Scenes/Gui/KeyBind.tscn")
export(NodePath) var grid
var changing = null
var prev_mouse = false

func _ready():
	grid = get_node(grid)
	for i in InputMap.get_actions():
		if i.begins_with("ui"): continue
		if InputMap.get_action_list(i):
			data[i] = InputMap.get_action_list(i)[0].as_text()
		else:
			data[i] = ""
		keys[data[i]] = i
		var t = textnode.instance()
		t.get_node("Label").text = i
		grid.add_child(t)
		var b = buttonnode.instance()
		b.connect("pressed2", self, "change")
		b._name = data[i]
		b.action = i
		buttons[i] = b
		grid.add_child(b)
		

func save_game():
	var save_game = File.new()
	save_game.open("user://bind.save", File.WRITE)
	save_game.store_line(to_json(data))
	save_game.close()
	
func _input(event):
	if event is InputEventKey and changing:
		var key = event.as_text()
		data[changing] = key
		InputMap.action_erase_events(changing)
		if keys.has(key):
			data[keys[key]] = ""
			buttons[keys[key]].change_name("None")
			InputMap.action_erase_events(keys[key])	
		buttons[changing].change_name(key)
		
		keys[key] = changing
		InputMap.action_add_event(changing, event)
		changing = null
		
func _process(delta):
	var press = Input.is_mouse_button_pressed(BUTTON_LEFT)
	if !press and prev_mouse and changing:
		var text = data[changing]
		if not text:
			text = "None"
		if changing: buttons[changing].change_name(text)		
		changing = null
#		print(1)
	prev_mouse = press
func change(action):
	changing = action
	prev_mouse = false
#	print(2)
	buttons[action].change_name("")


func _on_Button_pressed():
	visible = false

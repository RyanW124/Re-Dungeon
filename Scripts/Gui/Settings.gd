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
const f = "user://bind.save"
var prev_mouse = false

func _ready():
	var file = File.new()
	grid = get_node(grid)
	
	if file.file_exists(f):
		file.open(f, File.READ)
	
		data = file.get_var(true)
		for i in data:
			InputMap.action_erase_events(i)
			InputMap.action_add_event(i, data[i])
	else:
		for i in InputMap.get_actions():
			if i.begins_with("ui"): continue
			if InputMap.get_action_list(i):
				data[i] = InputMap.get_action_list(i)[0]
			else:
				data[i] = null
	for i in ['Left', 'Right', 'Up', 'Down', 'Attack1', 'Heavy',
				'Shoot', 'Ladder', 'Portal', 'Pause']:
		if data[i]: keys[data[i].as_text()] = i
		var t = textnode.instance()
		t.get_node("Label").text = i
		grid.add_child(t)
		var b = buttonnode.instance()
		b.connect("pressed2", self, "change")
		b.change_name(data[i].as_text() if data[i] else "unbound")
		b.action = i
		buttons[i] = b
		grid.add_child(b)
	
	
	
		

func save_game():
	var save_game = File.new()
	save_game.open("user://bind.save", File.WRITE)
	save_game.store_var(data, true)
	save_game.close()
	
func _input(event):
	if event is InputEventKey and changing:
		var key = event
		data[changing] = key
		InputMap.action_erase_events(changing)
		if keys.has(key.as_text()):
			data[keys[key.as_text()]] = null
			buttons[keys[key.as_text()]].change_name("None")
			InputMap.action_erase_events(keys[key.as_text()])	
		buttons[changing].change_name(key.as_text())
		
		keys[key.as_text()] = changing
		InputMap.action_add_event(changing, event)
		changing = null
		
func _process(delta):
	var press = Input.is_mouse_button_pressed(BUTTON_LEFT)
	if !press and prev_mouse and changing:
		var text = data[changing]
		if text:
			text = text.as_text()
		else:
			text = "unbound"
		if changing: buttons[changing].change_name(text)		
		changing = null
#		print(1)
	prev_mouse = press
func change(action):
	if changing:
		var text = data[changing]
		if text:
			text = text.as_text()
		else:
			text = "unbound"
		buttons[changing].change_name(text)		
	changing = action
	prev_mouse = false
#	print(2)
	buttons[action].change_name("")


func _on_Button_pressed():
	visible = false


func _on_Settings_tree_exiting():
	save_game()

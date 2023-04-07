extends Node
var upgrading = true
var dialogue = false
var paused = false
var cutscene = false
var health = 10
var speed = 10
var damage = 10
var coins = 10
var vision = 5
var jump = 10
var prev_time = null
var ammo = 100
var player
var powerup = false
var cam
var enemy_count = 0
var main
var start_time = 0
var end_time = 0
var deaths = 0
var pause_start = 0
var pause_time = 0
var level
var running = true
var in_game = false
var state = "Idle"
const f = "user://highscore.save"
var highscore
#func _ready():
#	reset()
#	get_tree().connect("node_added", self, "reset")
func _ready():
	var file = File.new()	
	if file.file_exists(f):
		file.open(f, File.READ)
		highscore = file.get_var(true)
	else:
		highscore = [null, null]
	
func save():
	var save_game = File.new()
	save_game.open(f, File.WRITE)
	save_game.store_var(highscore, true)
	save_game.close()
func reset():
	player = get_tree().root.get_node("Main").get_node("Player")
	cam = get_tree().root.get_node("Main").get_node("Camera2D")
	main = get_tree().root.get_node("Main")
	cam.make_current()
	upgrading = true
	dialogue = false
	paused = false
	cutscene = false
	running = true
	if deaths == 0:
		start_time = Time.get_unix_time_from_system()
		pause_time = 0
func bigreset(tutorial=false, l = 0):
	in_game = true
	level = l
	health = 10 * int(tutorial)
	speed = 10 * int(tutorial)
	damage = 10 * int(tutorial)
	coins = 0
	deaths = 0
	jump = 10 * int(tutorial)
	vision = 10 * int(tutorial)
	ammo = 10 * int(tutorial)
	state = ""
func get_key(action):
	var l = InputMap.get_action_list(action)
	return l[0].as_text().to_lower() if l else "unbound"
func parseTime(decimal=false, t=null):
	t = t if t else time()
	var seconds = fposmod(t, 60)
	var minutes = int(t/60)%60
	var hours = int(t/60)/60
	var text = ""
	if hours:
		text += "%02dh " % hours
	if minutes:
		text += "%02dm " % minutes
	text += ("%2.3fs" if decimal else "%02ds") % seconds
	return text
func end():
	in_game = false
	end_time = time()
	running = false
	var l = highscore[level]
	if !l or deaths < l[0] or (deaths == l[0] and end_time < l[1]):
		highscore[level] = [deaths, end_time]
		save()
func time():
	if prev_time != null:
		return prev_time
	if running:
		return Time.get_unix_time_from_system() - start_time - pause_time
	return end_time
func update(property, value):
	set(property, value)
	var prev = get_tree().paused
	get_tree().paused = upgrading or dialogue or paused or cutscene or powerup
	if !prev and get_tree().paused:
		pause_start = Time.get_unix_time_from_system()
		prev_time = time()
	elif prev and !get_tree().paused:
		pause_time += Time.get_unix_time_from_system() - pause_start
		prev_time = null

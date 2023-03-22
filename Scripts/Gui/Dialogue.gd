extends Control

var open = false
var dir = 1
signal closed

func _ready():
	$AnimationPlayer.play("RESET")
	hide()
	get_parent().hide()
	connect("closed", Callable(Save.main.get_node("FSM"), "_on_dialogue_closed"))

func display(text):
	$Timer.start(1)
	show()
	open = true
	$Label.text = text
	$AnimationPlayer.play("Open")
	get_parent().show()
	Save.update("dialogue", true)
	
	
func close():
	$AnimationPlayer.play_backwards("Open")
	open = false
	
func _process(delta):
	$Label2.modulate.a += delta * dir
	if $Label2.modulate.a < .5 or $Label2.modulate.a > 1:
		dir *= -1
		$Label2.modulate.a = clamp($Label2.modulate.a, .5, 1)
	
func _input(event):
	if event is InputEventKey and !event.is_echo() \
	and event.is_pressed() and event.as_text() != Save.get_key("Pause")\
	and $Timer.is_stopped() and !Save.paused and open:
		close()
		

func _on_AnimationPlayer_animation_finished(anim_name):
	if not open:
		hide()
		get_parent().hide()
		Save.update("dialogue", false)
		emit_signal("closed")
		
		
		

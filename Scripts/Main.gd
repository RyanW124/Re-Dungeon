extends Node2D

export var level:int
export(NodePath) var pause_menu
onready var fsm = $FSM
export var upgrade := true
onready var cutcam = $CutCam
onready var hint = $CanvasLayer/Hint
onready var powerup = $CanvasLayer/PowerUp
onready var overlay = $CanvasLayer/Overlay
onready var dialogue = $CanvasLayer/CenterContainer/Dialogue

func _ready():
	Save.reset()
	pause_menu = get_node(pause_menu)
	Save.update("upgrading", upgrade)
	$CanvasLayer/Overlay/Buy.visible = upgrade
	$CanvasLayer/ColorRect/Label.die()
	Save.enemy_count = 0
	
	for i in get_children():
		if i.is_in_group("Enemies"):
			Save.enemy_count += 1
func _on_activation(_name):
	fsm.on_act(_name)
#func _process(delta):
#	Save.time += delta

func cut_to(pos, time=1.5, t2 = 1.5):
	cutcam.cut_to(pos, time, t2)
func die():
	Save.deaths += 1
	$CanvasLayer/Overlay.hide()
	$CanvasLayer/ColorRect/AnimationPlayer.play("Die")
func _on_finish():
	$Camera2D.end()
	$TileMap.end()
	$Player.end()
	Save.end()

func transition():
	$CanvasLayer/ColorRect/AnimationPlayer.play("end")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "end":
		pass
#		get_tree().change_scene("res://Scenes/Start.tscn")
	elif anim_name == "Die":
		get_tree().reload_current_scene()

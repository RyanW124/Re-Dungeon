extends Node
class_name State

var state_machine: StateMachine = null
var player: KinematicBody2D = null
var prev = null
var active = false

func _ready():
	pass
	
func handle_input(event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass
func physics_update(_delta: float) -> void:
	pass
func some_event():
	pass
func anim_update():
	pass

# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_msg := {}) -> void:
	pass


# Virtual function. Called by the state machine before changing the active state. Use this function
# to clean up the state.
func exit() -> void:
	pass

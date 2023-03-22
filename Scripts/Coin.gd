extends Area2D

@export var explode # (String, FILE)
@export var color: Color
var collected = false
@export var property: String
func _ready():
	explode = load(explode).instantiate()
	explode.color = color
	explode.position = position
	explode.set_color(Color.ORANGE)

func _process(delta):
	if collected:
		modulate.a -= delta
		if modulate.a <= 0:
			queue_free()
func collect():
	collected = true
	Save.player.get_node("animation").play("item")
func _on_Coin_body_entered(body):
	if body.is_in_group("Player") and not collected:
		get_parent().add_child(explode)
		body.set(property, body.get(property)+1)
		explode.restart()
		collected = true
	

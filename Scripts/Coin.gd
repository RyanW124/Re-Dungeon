extends Area2D

export(String, FILE) var explode
func _ready():
	explode = load(explode).instance()
	explode.position = position
	explode.set_color(Color.orange)

func _on_Coin_body_entered(body):
	if body.is_in_group("Player"):
		get_parent().add_child(explode)
		body.coins += 1
		explode.restart()
		queue_free()
	

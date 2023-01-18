extends Area2D

var tilemap: TileMap

func _ready():
	pass



func _on_Kill_body_entered(body):
	if body.is_in_group("Player"):
		body.die()

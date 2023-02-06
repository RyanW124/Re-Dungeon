extends Area2D

export var max_health: float
var health = max_health
var tilemap: TileMap
export(String, FILE) var explode

func _ready():
	explode = load(explode).instance()
	explode.position = position + Vector2(8, 8)

func _process(delta):
	for area in get_overlapping_areas():
		if area.is_in_group("Projectile") and not area.disabled:
			health -= area.damage
			if health <= 0:
				tilemap.set_cell(position.x/tilemap.cell_size[0], position.y/tilemap.cell_size[0], -1)
				get_parent().add_child(explode)
				explode.restart()
				tilemap.make_graph()
				queue_free()

func _on_Breakable_body_entered(body):
	pass


func _on_Breakable_area_entered(area):
	pass

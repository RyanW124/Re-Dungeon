extends Area2D


var tilemap: TileMap


func _process(delta):
	for area in get_overlapping_areas():
		if area.is_in_group("Projectile") and not area.disabled:
			if area is Projectile:
				area.queue_free()

func _on_Breakable_body_entered(body):
	pass


func _on_Breakable_area_entered(area):
	pass

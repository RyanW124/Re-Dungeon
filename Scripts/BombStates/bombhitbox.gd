extends hitbox


func kb(body=null):
	return (body.position - get_parent().position).normalized()

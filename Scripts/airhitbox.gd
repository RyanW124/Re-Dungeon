extends hitbox

func kb(body=null):
	return super.kb(body) + Vector2.UP*3
func hit(body):
	super.hit(body)
	get_parent().fsm.some_event()

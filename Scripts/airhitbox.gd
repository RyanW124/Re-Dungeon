extends hitbox

func kb(body=null):
	return .kb(body) + Vector2.UP*3
func hit(body):
	.hit(body)
	get_parent().fsm.some_event()

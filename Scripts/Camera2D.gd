extends Camera2D


@onready var shakeTimer = $Timer
@onready var tween = $Tween
var detach = null
var target = 0
var speed = 2
var shake_amount = 0
var default_offset = offset
var vel = Vector2.ZERO
var rng = RandomNumberGenerator.new()
var shaking = false

func _ready():
	rng.randomize()

func _process(delta):
	var l = lerp(position, detach if detach else Save.player.position, speed * delta)
	vel = l - position
	position =  l
	if shaking: offset = Vector2(randf_range(-shake_amount, shake_amount), randf_range(-shake_amount, shake_amount)) * delta + default_offset
	rotation = fposmod(rotation, 2*PI)
	if abs(rotation - target) > 0.001:
		var prev = rotation < target
		var temp = rotation
		if rotation < target: temp += 2*PI
		rotate(delta if temp - target > PI else -delta)
		if (rotation < target) != prev:
			rotation = target
		


func shake(new_shake, shake_time=0.4, shake_limit=100):
	shake_amount += new_shake
	if shake_amount > shake_limit:
		shake_amount = shake_limit
	
	shakeTimer.wait_time = shake_time
	tween.stop_all()
	shaking = true
	shakeTimer.start()
func turn(t=1):
	var rot = rng.randf_range(-.5, .5)
	target += rot
	target = fposmod(target, 2*PI)
	await get_tree().create_timer(t).timeout
	target -= rot
	target = fposmod(target, 2*PI)
	
func end():
	var tile = get_parent().get_node("TileMap")
	detach = (tile.cell_to_v(tile.end) + tile.cell_to_v(tile.start))/2
	shake(50, 5)
	$AnimationPlayer.play("en")
func _on_Timer_timeout():
	shake_amount = 0
	shaking = false
	
	tween.interpolate_property(self, "offset", offset, default_offset,
	0.1, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	tween.start()

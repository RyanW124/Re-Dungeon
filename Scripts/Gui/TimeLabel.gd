extends Label


func _ready():
	text = Save.parseTime()
func _process(delta):
	text = Save.parseTime()

#	print(text)

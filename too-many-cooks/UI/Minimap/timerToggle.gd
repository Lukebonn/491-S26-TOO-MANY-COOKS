extends CheckButton

func _ready() -> void:
	if Global.timerEnabled:
		button_pressed = true
	else:
		button_pressed = false

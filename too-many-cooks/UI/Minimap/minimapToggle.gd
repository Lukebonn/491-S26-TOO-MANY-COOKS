extends CheckButton

func _ready() -> void:
	if Global.minimapEnabled:
		button_pressed = true
	else:
		button_pressed = false

extends CheckButton

func _ready():
	if get_window().is_embedded():
		disabled = true

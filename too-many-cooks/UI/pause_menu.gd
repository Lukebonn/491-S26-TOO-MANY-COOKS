extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		if visible:
			visible = false
			#get_tree().paused = false
		else:
			visible = true
			#get_tree().paused = true

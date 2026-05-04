extends AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_parent().get_parent().can_advance:
		play("ClickIndicator")
	else:
		play("NoClick")
		frame = 0

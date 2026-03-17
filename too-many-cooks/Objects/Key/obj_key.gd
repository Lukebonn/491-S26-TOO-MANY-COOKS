extends Node2D
signal key_collected

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		key_collected.emit()
		body.num_keys += 1
		queue_free()

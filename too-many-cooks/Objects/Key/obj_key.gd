extends Node2D
signal key_collected

func _on_area_2d_area_entered(_area: Area2D) -> void:
	key_collected.emit()
	queue_free()

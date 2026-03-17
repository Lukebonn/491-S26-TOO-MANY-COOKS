extends Node2D
signal on_unlock

func unlock() -> void:
	on_unlock.emit()
	queue_free()

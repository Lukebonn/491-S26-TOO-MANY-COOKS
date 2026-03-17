extends Node2D

func _ready() -> void:
	$Timer.wait_time = randf_range(1.0, 3.0)
	$Timer.start()

func _on_timer_timeout() -> void:
	queue_free()

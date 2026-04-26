extends StaticBody2D

func _ready() -> void:
	hide()
	$CollisionShape2D.disabled = true

func make_visible() -> void:
	show()
	$CollisionShape2D.disabled = false

func destroy_barrier() -> void:
	queue_free()

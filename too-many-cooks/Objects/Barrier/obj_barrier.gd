extends StaticBody2D

var art : AnimatedSprite2D

func _ready() -> void:
	art = $Barrier
	art.animation = "Close"
	art.frame = 0
	$CollisionShape2D.disabled = true

func make_visible() -> void:
	art.play("Close")
	$CollisionShape2D.disabled = false

func destroy_barrier() -> void:
	art.play("Open")
	$CollisionShape2D.disabled = true

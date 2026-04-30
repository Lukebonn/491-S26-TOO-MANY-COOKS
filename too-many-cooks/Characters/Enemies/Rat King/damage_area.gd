extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_create_damage_area(playerX: float, playerY: float) -> void:
	await get_tree().create_timer(1.0).timeout
	var copy = duplicate(DUPLICATE_USE_INSTANTIATION)
	copy.get_child(0).position = Vector2(playerX, playerY)
	position.x = playerX
	position.y = playerY

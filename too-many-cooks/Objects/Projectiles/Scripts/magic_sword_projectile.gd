extends RigidBody2D

var velocity : Vector2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation_degrees += 800 * delta
	velocity -= velocity/3 * delta
	move_and_collide(velocity)

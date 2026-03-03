extends RigidBody2D

var velocity : Vector2

func _physics_process(_delta):
	move_and_collide(velocity)

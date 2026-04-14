extends RigidBody2D

var velocity : Vector2

var damage : int

func _ready():
	damage = int((PlayerStats.base_str + PlayerStats.passive_str) * 1.4)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation_degrees += 800 * delta
	velocity -= velocity/3 * delta
	move_and_collide(velocity)


##projectile should disappear when it hits a wall
func _on_hitbox_body_entered(_body: Node2D) -> void:
	queue_free()

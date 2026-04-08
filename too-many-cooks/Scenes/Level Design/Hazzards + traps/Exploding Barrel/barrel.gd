extends StaticBody2D

@export var max_health: int = 50
@export var explosion_force: float = 20.0
@export var explosion_damage: int = 40

var health: int

func _ready():
	health = max_health

func apply_damage(amount: int):
	health -= amount
	if health <= 0:
		explode() 

func explode():
	# Enable explosion area
	$ExplosionArea.monitoring = true
	# Apply force + damage to bodies inside
	for body in $ExplosionArea.get_overlapping_bodies():
		if body.has_method("apply_damage"):
			body.apply_damage(explosion_damage)
		if body is RigidBody3D:
			var dir = (body.global_transform.origin - global_transform.origin).normalized()
			body.apply_impulse(dir * explosion_force)
			queue_free()

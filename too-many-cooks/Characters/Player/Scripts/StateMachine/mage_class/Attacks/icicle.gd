extends RigidBody2D

var velocity : Vector2

var damage : int

func _ready():
	damage = int(get_parent().strength * 1.5)

func _physics_process(_delta):
	move_and_collide(velocity)

##code that should execute when the projectile hits an enemy
#projectile despawns when hitting an enemy
func _on_hitbox_area_entered(_area):
	queue_free()

extends RigidBody2D

var velocity : Vector2

var damage : int

func _ready():
	damage = int((PlayerStats.base_str + PlayerStats.passive_str) * 1.5)

func _physics_process(_delta):
	move_and_collide(velocity)

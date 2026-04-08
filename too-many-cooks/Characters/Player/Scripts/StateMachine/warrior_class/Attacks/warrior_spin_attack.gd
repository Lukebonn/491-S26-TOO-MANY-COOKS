extends RigidBody2D

var damage : int

func _ready():
	damage = int(get_parent().strength * 1.8)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation += 30 * delta

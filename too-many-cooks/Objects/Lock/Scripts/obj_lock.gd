extends Node2D
signal on_unlock

##The radius of the base collision shape in this Lock.
@export var CollisionRadius = 16.0

func _ready() -> void:
	$BaseColObj/BaseCol.shape.radius = CollisionRadius

func unlock() -> void:
	on_unlock.emit()
	queue_free()

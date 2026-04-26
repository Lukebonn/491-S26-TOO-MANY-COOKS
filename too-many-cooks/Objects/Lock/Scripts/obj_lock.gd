extends Node2D
signal on_unlock

##The radius of the base collision shape in this Lock.
@export var CollisionRadius = 16.0
@export var keyType: PlayerStats.KeyType
@export var displayName: String = "_Untitled_ Key"

func _ready() -> void:
	$BaseColObj/BaseCol.shape.radius = CollisionRadius

func unlock() -> void:
	if PlayerStats.has_key(keyType):
		PlayerStats.remove_key(keyType)
		print("You unlocked: " + displayName + " Key door")
		on_unlock.emit()
		queue_free()
	else:
		print("Requires: " + displayName + " Key")

extends Node2D
signal on_unlock

##The radius of the base collision shape in this Lock.
@export var CollisionRadius = 16.0
@export var keyType: PlayerStats.KeyType
@export var displayName: String = "_Untitled_ Key"
@export var key_sprites: Array[Texture2D]
@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	$BaseColObj/BaseCol.shape.radius = CollisionRadius
	sprite.texture = key_sprites[keyType]
	add_to_group("lock")

func unlock() -> void:
	if PlayerStats.has_key(keyType):
		PlayerStats.remove_key(keyType)
		print("You unlocked a door using the " + displayName)
		on_unlock.emit()
		queue_free()
	else:
		print("Requires: " + displayName + " Key")

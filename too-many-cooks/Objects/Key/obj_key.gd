extends Node2D
signal key_collected

var player : Node2D
#Ref to collided Player, for collecting Key when made visible.
##Whether or not this Key should start hidden and made visible later.
##Set to True if this Key must be collected after some event,
##like defeating enemies from a Spawner.
@export var StartHidden = false
@export var keyType: PlayerStats.KeyType
@export var displayName: String = "_Untitled_ Key"
@export var key_sprites: Array[Texture2D]
@onready var sprite: Sprite2D = $Sprite2D


func _ready() -> void:
	add_to_group("key")
	sprite.texture = key_sprites[keyType]
	visible = not StartHidden

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player = body
		if visible:
			give_key()
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player = null

func _on_visibility_changed() -> void:
	if player:
		give_key()

func give_key() -> void:
	key_collected.emit()
	PlayerStats.add_key(keyType)
	print("Player picked up the " + displayName + "!")
	queue_free()

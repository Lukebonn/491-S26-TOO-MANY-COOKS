extends Node2D
signal key_collected

var player : Node2D
#Ref to collided Player, for collecting Key when made visible.
@export var StartHidden = false
#Whether this Key should be hidden on start and made visible later.

func _ready() -> void:
	visible = not StartHidden

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player = body
		if visible:
			give_key()

func _on_visibility_changed() -> void:
	if player:
		give_key()

func give_key() -> void:
	key_collected.emit()
	player.num_keys += 1
	queue_free()

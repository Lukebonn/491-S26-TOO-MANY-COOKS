extends Area2D

var spawner : Node2D
#Ref to parent Enemy Spawner.

func _ready() -> void:
	spawner = get_parent()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		spawner.try_spawn_enemies()

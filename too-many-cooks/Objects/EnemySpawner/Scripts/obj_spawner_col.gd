extends Area2D

var spawner : Node2D
#Ref to parent Enemy Spawner.
var touched : bool = false
#Whether or not this collision has already been touched (spawn trigger is one shot).

func _ready() -> void:
	spawner = get_parent()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" && not touched:
		spawner.try_spawn_enemies()
		touched = true

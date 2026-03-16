extends Area2D

var spawner : Node2D
#Ref to parent Enemy Spawner.

func _ready() -> void:
	spawner = get_parent()

func _on_area_entered(_area: Area2D) -> void:
	spawner.try_spawn_enemies()

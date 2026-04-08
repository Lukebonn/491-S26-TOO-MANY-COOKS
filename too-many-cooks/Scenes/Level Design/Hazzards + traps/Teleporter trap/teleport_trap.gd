extends Area2D

#@export var teleport_target: Node2D


func _on_body_entered(body: CharacterBody2D) -> void:
	if body.name == "Player":
		body.set_position($"Destination Point".global_position)

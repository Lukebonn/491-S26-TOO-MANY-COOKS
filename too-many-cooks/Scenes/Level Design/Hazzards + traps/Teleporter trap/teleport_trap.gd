extends Area2D

#@export var teleport_target: Node2D


func _on_area_entered(area: Area2D) -> void:
	#ideally would add a group to the player but idk why this isnt working
	#if body.is_in_group("Player"):
	if area.has_method("_on_hurtbox_area_entered"):
		area.set_position($"Destination Point".global_position)

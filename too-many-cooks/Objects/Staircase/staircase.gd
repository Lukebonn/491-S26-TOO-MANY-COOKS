extends Area2D

@export var destination_path : String

##when the player touches the staircase it should load a different scene
func _on_body_entered(_body: Node2D) -> void:
	call_deferred("go_to_scene")

##loads the scene set in destination
func go_to_scene():
	get_tree().change_scene_to_file(destination_path)

func enable():
	monitoring = true
	visible = true

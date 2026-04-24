extends Button

@export var hoverSound : AudioStreamPlayer
@export var clickSound : AudioStreamPlayer

func _on_mouse_entered() -> void:
	if hoverSound:
		hoverSound.play()

func _on_button_down() -> void:
	if clickSound:
		clickSound.play()

func _on_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Tavern/tavern.tscn")

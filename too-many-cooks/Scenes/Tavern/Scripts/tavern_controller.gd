extends Node2D

@export var in_dialogue = false

signal next_line

func _input(event):
	if event is InputEventMouseButton:
		next_line.emit()


func _on_pause_button_pressed() -> void:
	pass # Replace with function body.

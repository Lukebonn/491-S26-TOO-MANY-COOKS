extends Node2D

@export var in_dialogue = false

signal next_line

func _input(event):
	if event is InputEventMouseButton:
		next_line.emit()

extends Node2D

var first_time = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if first_time == false:
		queue_free()
	elif first_time == true:
		show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_button_pressed():
	queue_free()
	first_time = false

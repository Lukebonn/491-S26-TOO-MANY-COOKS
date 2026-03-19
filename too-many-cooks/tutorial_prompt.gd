extends Node2D

var first_time = true
# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.First_Time_Tavern:
		show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_button_pressed():
	queue_free()
	Global.First_Time_Combat = false

extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("pause")):
		show()
		get_tree().paused = true


func _on_resume_pressed():
	if get_tree().paused == true:
		get_tree().paused = false
		hide()


func _on_quit_pressed():
	get_tree().change_scene_to_file("res://Scenes/Title/title_screen.tscn")

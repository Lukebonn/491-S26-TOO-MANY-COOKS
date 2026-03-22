extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float):
	pass


func _on_resume_pressed():
	if Global.Paused_In_Tavern == true:
		get_tree().change_scene_to_file("res://Scenes/Tavern/tavern.tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/Test/PlayerEnemyTest/combat_test.tscn")


func _on_quit_pressed():
	get_tree().change_scene_to_file("res://Scenes/Title/title_screen.tscn")

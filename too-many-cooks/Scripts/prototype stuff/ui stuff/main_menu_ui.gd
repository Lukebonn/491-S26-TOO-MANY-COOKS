extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_title_ui_stop_spinning_enivonment():
	menu_ui_come_in()

func menu_ui_come_in():
	get_tree().create_timer(1.0)
	var tween = get_tree().create_tween()
	tween.tween_property($Sidebar,"position",(Vector2(1152.0*.55,0)),1).set_trans(Tween.TRANS_EXPO)
	for button in $Buttons/VBoxContainer.get_children():
		tween.tween_property(button, "position", Vector2(button.position.x-360,button.position.y), 0.1).set_trans(Tween.TRANS_CUBIC)

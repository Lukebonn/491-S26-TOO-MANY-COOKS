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
	tween.tween_property($Sidebar/PanelMain,"position",(Vector2(-1152.0*.57,0)),1).set_trans(Tween.TRANS_EXPO)
	for button in $Buttons/VBoxContainer.get_children():
		tween.tween_property(button, "position", Vector2(button.position.x-360,button.position.y), 0.1).set_trans(Tween.TRANS_CUBIC)

func _on_settings_pressed():
	menu_ui_to_settings()

func menu_ui_to_settings():
	var tween = get_tree().create_tween().set_parallel(true)
	#this is so messy but its a prototype haha
	tween.parallel().tween_property($"../Title UI/titletop","position",Vector2(0,-500),.3)
	for button in $Buttons/VBoxContainer.get_children():
		tween.tween_property(button, "position", Vector2(button.position.x+360,button.position.y), button.get_index()*0.1).set_trans(Tween.TRANS_CUBIC)
	for panel in $Sidebar.get_children():
		tween.tween_property(panel,"position",(Vector2(-1300,0)),panel.get_index()+1*.6).set_trans(Tween.TRANS_EXPO)
	tween.tween_property($"Pause UI","position",Vector2(0,0),1).set_trans(Tween.TRANS_EXPO)
	

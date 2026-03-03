extends Control
# Carson made this so yell at her if you want something different

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
	$"Pause UI/PauseStuff/TooltipReader".text = "Hello!"
	var tween = get_tree().create_tween().set_parallel(true)
	#this is so messy but its a prototype haha
	tween.parallel().tween_property($"../Title UI/titletop","position",Vector2(-576,-0),.3)
	for button in $Buttons/VBoxContainer.get_children():
		tween.tween_property(button, "position", Vector2(button.position.x+360,button.position.y), button.get_index()*0.1).set_trans(Tween.TRANS_CUBIC)
	for panel in $Sidebar.get_children():
		tween.tween_property(panel,"position",(Vector2(-1300,0)),panel.get_index()+1*.6).set_trans(Tween.TRANS_EXPO)
	await create_tween().tween_interval(.5).finished
	var tween_two = get_tree().create_tween()
	tween.tween_interval(.5)
	tween_two.parallel().tween_property($"Pause UI/PauseStuff","position",Vector2(1100,80),2).set_trans(Tween.TRANS_EXPO)
	tween_two.parallel().tween_property($"Pause UI/Back","position",Vector2(1932,506),2).set_trans(Tween.TRANS_EXPO)


func _on_back_pressed():
	$"Pause UI/PauseStuff/TooltipReader".text = "Bye!"
	var tween = get_tree().create_tween()
	tween.parallel().tween_property($"Pause UI/PauseStuff","position",Vector2(-2000,80),2).set_trans(Tween.TRANS_EXPO)
	tween.parallel().tween_property($"Pause UI/Back","position",Vector2(1932,900),2).set_trans(Tween.TRANS_EXPO)
	tween.set_parallel(true)
	for panel in $Sidebar.get_children():
		if panel.name == "PanelMain":
			pass
		else:
			tween.tween_property(panel,"position",(Vector2(0,0)),panel.get_index()+1*.2).set_trans(Tween.TRANS_EXPO)
	await create_tween().tween_interval(.5).finished
	var tween_two = get_tree().create_tween()
	tween_two.parallel().tween_property($Sidebar/PanelMain,"position",(Vector2(-1152.0*.57,0)),.6).set_trans(Tween.TRANS_EXPO)
	tween_two.parallel().tween_property($"../Title UI/titletop","position",Vector2(576,0),.3)
	for button in $Buttons/VBoxContainer.get_children():
		tween_two.tween_property(button, "position", Vector2(button.position.x-360,button.position.y), button.get_index()*0.06).set_trans(Tween.TRANS_EXPO)
		#this "button.postion" is problematic it can be wrong if people spam!!! fix when bored

func _on_master_slider_value_changed(value):
	#dude this reference is so long its actually killing me :sob:
	$"Pause UI/PauseStuff/MarginContainer/TabContainer/Audio/Audio Sliders/HBoxContainer/masterlabel".text = "  " +  \
	str($"Pause UI/PauseStuff/MarginContainer/TabContainer/Audio/Audio Sliders/HBoxContainer/Master Audio/MasterSlider".value*100) \
	+ "%"
	AudioServer.set_bus_volume_db(0, linear_to_db(value))
	
func _on_music_slider_value_changed(value):
	$"Pause UI/PauseStuff/MarginContainer/TabContainer/Audio/Audio Sliders/HBoxContainer2/musiclabel".text = "  " + \
	str($"Pause UI/PauseStuff/MarginContainer/TabContainer/Audio/Audio Sliders/HBoxContainer2/Music Audio/MusicSlider".value*100) \
	+ "%"
	AudioServer.set_bus_volume_db(1, linear_to_db(value))

func _on_sfx_slider_value_changed(value):
	$"Pause UI/PauseStuff/MarginContainer/TabContainer/Audio/Audio Sliders/HBoxContainer3/sfxlabel".text = "  " +  \
	str($"Pause UI/PauseStuff/MarginContainer/TabContainer/Audio/Audio Sliders/HBoxContainer3/SFX Audio/SFXSlider".value*100) \
	+ "%"
	AudioServer.set_bus_volume_db(2, linear_to_db(value))

func _on_purple_toggle_pressed():
	if $"../Menu part/Cat".modulate == Color(.8,0,.8):
		$"../Menu part/Cat".modulate = Color(1,1,1)
	else:
		$"../Menu part/Cat".modulate = Color(.8,0,.8)

func _on_fullscreentoggle_toggled(toggled_on):
	
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

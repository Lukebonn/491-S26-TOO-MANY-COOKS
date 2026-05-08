extends Control
signal closed_menu
signal opened_menu
@export var clickSound : AudioStreamPlayer
@export var hoverSound : AudioStreamPlayer
func show_menu():
	$"PauseStuff/TooltipReader".text = "Hello!"
	var tween = self.create_tween()
	tween.parallel().tween_property(self,"position",Vector2(0,0),2).set_trans(Tween.TRANS_EXPO)
	opened_menu.emit()

func hide_menu():
	$"PauseStuff/TooltipReader".text = "Bye!"
	var tween = self.create_tween()
	tween.parallel().tween_property(self,"position",Vector2(1152,0),2).set_trans(Tween.TRANS_EXPO)
	closed_menu.emit()
func _on_back_pressed():
	hide_menu()
	clickSound.play()

func _on_master_slider_value_changed(value):
	#dude this reference is so long its actually killing me :sob:
	$"PauseStuff/MarginContainer/TabContainer/Audio/Audio Sliders/HBoxContainer/masterlabel".text = "  " +  \
	str($"PauseStuff/MarginContainer/TabContainer/Audio/Audio Sliders/HBoxContainer/Master Audio/MasterSlider".value*100) \
	+ "%"
	AudioServer.set_bus_volume_db(0, linear_to_db(value))
	SaveMgr.GameData.master_volume = value
	
func _on_music_slider_value_changed(value):
	$"PauseStuff/MarginContainer/TabContainer/Audio/Audio Sliders/HBoxContainer2/musiclabel".text = "  " + \
	str($"PauseStuff/MarginContainer/TabContainer/Audio/Audio Sliders/HBoxContainer2/Music Audio/MusicSlider".value*100) \
	+ "%"
	AudioServer.set_bus_volume_db(1, linear_to_db(value))
	SaveMgr.GameData.music_volume = value

func _on_sfx_slider_value_changed(value):
	$"PauseStuff/MarginContainer/TabContainer/Audio/Audio Sliders/HBoxContainer3/sfxlabel".text = "  " +  \
	str($"PauseStuff/MarginContainer/TabContainer/Audio/Audio Sliders/HBoxContainer3/SFX Audio/SFXSlider".value*100) \
	+ "%"
	AudioServer.set_bus_volume_db(2, linear_to_db(value))
	SaveMgr.GameData.sound_volume = value

func _on_fullscreentoggle_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		clickSound.play()
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		clickSound.play()


func _on_music_slider_drag_started() -> void:
	clickSound.play()


func _on_sfx_slider_drag_started() -> void:
	clickSound.play()


func _on_combat_settings_rich() -> void:
	$Objective.set_text("Collect 150 gold")

extends Node2D
var in_menu = false
var in_settings_menu = false
signal menu_animations_complete
signal show_warning_menu
signal show_pause_objective(objective_title)


# Called when the node enters the scene tree for the first time.
func _ready():
	show()
	

func do_settings_action(action: String):
	match action:
		"show_menu":
			in_menu = true
			var tween = self.create_tween()
			tween.tween_property($cover,"position",Vector2(0,0),0.1).set_trans(Tween.TRANS_EXPO)
			tween.tween_property($background,"position",$BgMarker.position,0.2).set_trans(Tween.TRANS_EXPO)
			var i = 1
			for button in $buttons.get_children():
				tween.tween_property(button, "global_position", Vector2($Marker2D.position.x+120,(3.5*i*20)+300), 0.05).set_trans(Tween.TRANS_EXPO)
				i += 1

		"hide_menu":
			in_menu = false
			var tween = self.create_tween()
			for sprite in $buttons.get_children():
				tween.tween_property(sprite, "position", Vector2($Marker2D.position.x+160,sprite.position.y), 0.02).set_trans(Tween.TRANS_EXPO)
			tween.tween_property($background,"position",$Marker2D2.position,0.1).set_trans(Tween.TRANS_EXPO)
			tween.tween_property($cover,"position",$topleft.position,0.1).set_trans(Tween.TRANS_EXPO)
			menu_animations_complete.emit()
		"submenu":
			var tween = self.create_tween()
			#tween.tween_property($background,"position",$Marker2D2.position,0.1).set_trans(Tween.TRANS_EXPO)
		"remove_buttons":
			var tween = self.create_tween()
			tween.tween_property($background,"position",$Marker2D2.position,0.1).set_trans(Tween.TRANS_EXPO)
			for sprite in $buttons.get_children():
				tween.tween_property(sprite, "position", Vector2($Marker2D.position.x+160,sprite.position.y), 0.02).set_trans(Tween.TRANS_EXPO)

func _on_settings_button_pressed():
	$Journals.hide_menu()
	do_settings_action("remove_buttons")
	$"Pause UI".show_menu()



func _on_save_button_pressed():
	print("This does nothing!")


func _on_journal_button_pressed():
	do_settings_action("submenu")
	$Journals.show_menu()

func _on_title_button_pressed() -> void:
	FadeInFadeOut.fade_out()
	await get_tree().create_timer(1.2).timeout
	FadeInFadeOut.fade_in()
	get_tree().change_scene_to_file("res://Scenes/Title/title_screen.tscn")

func _on_exit_button_pressed():
	if $"../Objective Name":
		$"../Objective Name".modulate = Color(1,1,1,0)
	$Mouse_Blocker.show()
	do_settings_action("hide_menu")
	in_menu = false
	$Journals.hide_menu()
	$JournalPanel.hide_menu()
	$"Pause UI".hide_menu()
	await get_tree().create_timer(1).timeout
	$Mouse_Blocker.hide()
	

func _on_button_5_pressed():
	print("Uhh...")


func _on_button_6_pressed():
	pass # Replace with function body.


func _on_pause_ui_closed_menu():
	if in_menu:
		await get_tree().create_timer(1.5).timeout
		do_settings_action("show_menu")
		in_settings_menu = false

func _on_pause_ui_opened_menu() -> void:
	in_settings_menu = true
	#show_pause_objective.emit()

func _on_journal_pressed():
	do_settings_action("show_menu")


func _on_tavern_button_pressed() -> void:
	show_warning_menu.emit()
	#for i in range($buttons.get_child_count()):
		#if $buttons.get_child(i).visible == true:
			#$buttons.get_child(i).set_disabled(true)


func _on_exited_warning_menu() -> void:
	pass
	#print("hi")
	#for i in range($buttons.get_child_count()):
		#if $buttons.get_child(i).visible == true:
			#$buttons.get_child(i).set_disabled(false)


func _on_objective_manager_pause_objective(objective_title: Variant) -> void:
	show_pause_objective.emit(objective_title)

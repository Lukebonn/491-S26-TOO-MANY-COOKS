extends Node2D
var in_menu = false
# Called when the node enters the scene tree for the first time.
func _ready():
	show()

func do_settings_action(action: String):
	match action:
		"show_menu":
			in_menu = true
			var tween = get_tree().create_tween()
			tween.tween_property($cover,"position",Vector2(0,0),0.1).set_trans(Tween.TRANS_EXPO)
			tween.tween_property($background,"position",$Marker2D.position,0.2).set_trans(Tween.TRANS_EXPO)
			var i = 1
			for button in $buttons.get_children():
				tween.tween_property(button, "global_position", Vector2($Marker2D.position.x+65,4*i*20), 0.05).set_trans(Tween.TRANS_EXPO)
				i += 1

		"hide_menu":
			var tween = get_tree().create_tween()
			for sprite in $buttons.get_children():
				tween.tween_property(sprite, "position", Vector2($Marker2D.position.x+160,sprite.position.y), 0.02).set_trans(Tween.TRANS_EXPO)
			tween.tween_property($background,"position",$Marker2D2.position,0.1).set_trans(Tween.TRANS_EXPO)
			
			tween.tween_property($cover,"position",$topleft.position,0.1).set_trans(Tween.TRANS_EXPO)
		"submenu":
			var tween = get_tree().create_tween()
			#tween.tween_property($background,"position",$Marker2D2.position,0.1).set_trans(Tween.TRANS_EXPO)
		"remove_buttons":
			var tween = get_tree().create_tween()
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


func _on_exit_button_pressed():
	do_settings_action("hide_menu")
	in_menu = false
	$Journals.hide_menu()
	$"Pause UI".hide_menu()

func _on_button_5_pressed():
	print("Uhh...")


func _on_button_6_pressed():
	pass # Replace with function body.


func _on_pause_ui_closed_menu():
	if in_menu:
		await get_tree().create_timer(1.5).timeout
		do_settings_action("show_menu")


func _on_journal_pressed():
	do_settings_action("show_menu")

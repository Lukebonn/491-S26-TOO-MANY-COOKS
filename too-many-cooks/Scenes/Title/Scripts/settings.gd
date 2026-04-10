extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	show()
	do_settings_action("show_menu")
	await get_tree().create_timer(3).timeout
	do_settings_action("hide_menu")
func do_settings_action(action: String):
	match action:
		"show_menu":
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
		


func _on_settings_button_pressed():
	do_settings_action("hide_menu")
	$"Pause UI".show_menu()
	do_settings_action("show_menu")


func _on_save_button_pressed():
	pass # Replace with function body.


func _on_journal_button_pressed():
	pass # Replace with function body.


func _on_exit_button_pressed():
	pass # Replace with function body.


func _on_button_5_pressed():
	pass # Replace with function body.


func _on_button_6_pressed():
	pass # Replace with function body.

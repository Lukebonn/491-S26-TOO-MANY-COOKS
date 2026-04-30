extends Node2D

var warning_prompted
signal exited_warning_menu

func _on_no_button_pressed() -> void:
	var tween = self.create_tween()
	tween.tween_property(
		self,
		"position",
		Vector2(0,500),
		0.5).set_trans(Tween.TRANS_EXPO)
	await tween.finished
	$AreYouSure.hide()
	$YesButton.add_theme_font_size_override("font_size", 50)
	$YesButton.text = "Yes"
	warning_prompted = false
	exited_warning_menu.emit()

func _on_show_warning_menu() -> void:
	if not warning_prompted:
		warning_prompted = true
		if randi_range(0, 100) == 100:
			$AreYouSure.show()
			$YesButton.add_theme_font_size_override("font_size", 25)
			$YesButton.text = "Pretty\nSure!"
		var tween = self.create_tween()
		tween.tween_property(
			self,
			"position",
			Vector2(0,0),
			0.5).set_trans(Tween.TRANS_EXPO)

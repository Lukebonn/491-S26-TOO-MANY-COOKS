extends Panel
@export var ClickSound : AudioStreamPlayer
@export var HoverSound : AudioStreamPlayer
func show_menu():
	var tween = self.create_tween()
	tween.tween_property(self,"position",Vector2(40,40),0.5).set_trans(Tween.TRANS_CUBIC)
	
func hide_menu():
	var tween = self.create_tween()
	tween.tween_property(self,"position",Vector2(1152,40),0.5).set_trans(Tween.TRANS_CUBIC)
	


func _on_exit_journals_pressed():
	ClickSound.play()
	hide_menu()


func _on_exit_journals_mouse_entered() -> void:
	HoverSound.play()

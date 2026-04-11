extends Panel

func show_menu():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"position",Vector2(40,40),1).set_trans(Tween.TRANS_CUBIC)
	
func hide_menu():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"position",Vector2(1152,40),1).set_trans(Tween.TRANS_CUBIC)
	


func _on_exit_journals_pressed():
	hide_menu()

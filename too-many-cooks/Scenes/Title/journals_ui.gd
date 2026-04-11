extends Control
signal closed_menu

func show_menu():
	var tween = get_tree().create_tween()
	tween.parallel().tween_property(self,"position",Vector2(0,0),.5).set_trans(Tween.TRANS_EXPO)

func hide_menu():
	var tween = get_tree().create_tween()
	tween.parallel().tween_property(self,"position",Vector2(1152,0),2).set_trans(Tween.TRANS_EXPO)
	closed_menu.emit()

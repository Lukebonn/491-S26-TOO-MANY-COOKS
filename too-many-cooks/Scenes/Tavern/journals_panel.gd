extends Panel

func show_menu():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"position",Vector2(0,0),1)
	
func hide_menu():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"position",Vector2(0,-640),1)
	

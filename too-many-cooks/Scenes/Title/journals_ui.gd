extends Control
signal closed_menu
@export var clickSound : AudioStreamPlayer
@export var hoverSound : AudioStreamPlayer

func show_menu():
	check_all_entries()
	var tween = get_tree().create_tween()
	tween.parallel().tween_property(self,"position",Vector2(0,0),.5).set_trans(Tween.TRANS_EXPO)


func hide_menu():
	var tween = get_tree().create_tween()
	tween.parallel().tween_property(self,"position",Vector2(1152,0),.5).set_trans(Tween.TRANS_EXPO)
	closed_menu.emit()

func _on_exit_journals_pressed():
	clickSound.play()
	show_menu()


func _on_exit_journals_mouse_entered():
	hoverSound.play()

func check_all_entries():
	for entry in $TabContainer/Warrior/Entries.get_children():
		entry.check_avaliablilty()
	for entry in $TabContainer/Rogue/Entries.get_children():
		entry.check_avaliablilty()
	for entry in $TabContainer/Mage/Entries.get_children():
		entry.check_avaliablilty()

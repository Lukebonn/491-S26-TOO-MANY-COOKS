extends Control
var is_showing = false

signal class_selected(name_of_class: String)
signal class_checked(name_of_class: String)

func _on_warrior_pressed():
	class_selected.emit("Warrior")
	hide_menu_top()


func _on_rogue_pressed():
	class_selected.emit("Rouge")
	hide_menu_top()


func _on_magician_pressed():
	class_selected.emit("Mage")
	hide_menu_top()


func _on_warrior_check_pressed():
	class_checked.emit("Warrior")
	hide_menu_top()


func _on_rogue_check_pressed():
	class_checked.emit("Rouge")
	hide_menu_top()


func _on_magician_check_pressed():
	class_checked.emit("Mage")
	hide_menu_top()
	
func show_menu():
	is_showing = true
	var tween = get_tree().create_tween()
	tween.tween_property(self,"position",Vector2(self.position.x,320),.5).set_trans(Tween.TRANS_CUBIC)


func hide_menu():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"position",Vector2(self.position.x,1000),.5).set_trans(Tween.TRANS_CUBIC)
	await tween.finished
	is_showing = false

func hide_menu_top():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"position",Vector2(self.position.x,-1000),.5).set_trans(Tween.TRANS_CUBIC)
	is_showing = false


func _on_close_pressed():
	hide_menu()

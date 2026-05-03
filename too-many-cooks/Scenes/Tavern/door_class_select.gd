extends Control
var is_showing = false

signal class_selected(name_of_class: String)
signal class_checked(name_of_class: String)

func _on_warrior_pressed():
	class_selected.emit("Warrior")
	Global.Warrior_Objective = true
	hide_menu_top()

func _on_rogue_pressed():
	class_selected.emit("Rogue")
	Global.Rogue_Objective = true
	hide_menu_top()


func _on_magician_pressed():
	class_selected.emit("Mage")
	Global.Mage_Objective = true
	hide_menu_top()


func _on_warrior_check_pressed():
	class_checked.emit("Warrior")
	hide_menu_top()


func _on_rogue_check_pressed():
	class_checked.emit("Rogue")
	hide_menu_top()


func _on_magician_check_pressed():
	class_checked.emit("Mage")
	hide_menu_top()
	
func show_menu():
	is_showing = true
	$Container.show()
	check_availability()
	var tween = get_tree().create_tween()
	tween.tween_property(self,"position",Vector2(self.position.x,320),.5).set_trans(Tween.TRANS_CUBIC)

func hide_menu():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"position",Vector2(self.position.x,1000),.5).set_trans(Tween.TRANS_CUBIC)
	await tween.finished
	$Container.hide()
	is_showing = false

func hide_menu_top():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"position",Vector2(self.position.x,-1000),.5).set_trans(Tween.TRANS_CUBIC)
	is_showing = false

func _on_close_pressed():
	hide_menu()

func check_availability():
	if Global.Has_Mage_NPC == true:
		$Panel/VBoxContainer/MarginContainer2/VBoxContainer/Classes/Magician.disabled = false
		$Panel/VBoxContainer/MarginContainer2/VBoxContainer/Checks/MagicianCheck.disabled = false
		$Panel/VBoxContainer/MarginContainer2/VBoxContainer/Classes/staff.show()
	if Global.Has_Rogue_NPC == true:
		$Panel/VBoxContainer/MarginContainer2/VBoxContainer/Classes/Rogue.disabled = false
		$Panel/VBoxContainer/MarginContainer2/VBoxContainer/Checks/RogueCheck.disabled = false
		$Panel/VBoxContainer/MarginContainer2/VBoxContainer/Classes/knife.show()

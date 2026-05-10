extends ColorRect

#Unique bool specific for how the Gramps NPC behaves (dialogue not within Class Menu).
var gramps : bool = false

#Main functions for dimming and undimming the screen.
func dim() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self,"color",Color(0.0, 0.0, 0.0, 0.588),.25)
func undim() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self,"color",Color(0.0, 0.0, 0.0, 0.0),.25)

#Dim/undims for standard NPC interactions.
func _on_class_menu_on_menu_shown() -> void:
	dim()
func _on_class_menu_on_menu_left() -> void:
	undim()

#Dims/undims for Tower prep menus.
func _on_class_select_on_menu_show() -> void:
	dim()
func _on_class_select_on_menu_left() -> void:
	undim()
	$"../Exit".disabled = false
func _on_act_select_on_menu_left() -> void:
	undim()
	$"../Exit".disabled = false

#Dims/undims specific to the Gramps NPC.
func _on_gramps_button_down() -> void:
	dim()
	gramps = true
func _on_dialogue_box_message_complete() -> void:
	if gramps:
		undim()

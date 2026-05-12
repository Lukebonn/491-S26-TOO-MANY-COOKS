extends Control
var is_showing = false
@export var dialogue_ref : Control

var current_class : String
var class_id : int = 0
var current_level
var current_ability_level 
var gold_upgrade_price
var orb_upgrade_price
@onready var requires_label_ref = $Panel/VBoxContainer/HBoxContainer/Stats/Upgrade/Label
@onready var ability_label_ref = $Panel/VBoxContainer/HBoxContainer/Abilities/Upgrade/Label
signal on_menu_shown
signal back_pressed
signal on_menu_left

func show_menu():
	is_showing = true
	$Container.show()
	$Panel/VBoxContainer/HBoxContainer/Abilities/Upgrade.disabled = !_check_upgrade_avaliability()
	var tween = get_tree().create_tween()
	tween.tween_property(self,"position",Vector2(self.position.x,320),.5).set_trans(Tween.TRANS_CUBIC)
	is_showing = true
	on_menu_shown.emit()
	$Panel/VBoxContainer/HBoxContainer/Abilities/Upgrade.disabled = !_check_ability_avaliability()

func hide_menu():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"position",Vector2(self.position.x,1000),.5).set_trans(Tween.TRANS_CUBIC)
	await tween.finished
	$Container.hide()
	current_class = ""
	is_showing = false

func hide_menu_top():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"position",Vector2(self.position.x,-1000),.5).set_trans(Tween.TRANS_CUBIC)

func set_title(new_name, level, ability_level):
	$Panel/VBoxContainer/Class_Name.text = "The "
	$Panel/VBoxContainer/Class_Name.text += str(new_name)
	$Panel/VBoxContainer/HBoxContainer/Stats/ClassLv.text = "Level " + str(level)
	current_class = new_name
	current_level = level
	current_ability_level = ability_level
	match current_class:
		"Warrior":
			class_id = 0
		"Mage":
			class_id = 1
		"Rogue":
			class_id = 2

func set_active_labels(active_str, active_hp, active_def, active_spd, active_mana):
	$Panel/VBoxContainer/HBoxContainer/Stats/Numbers/ClassNum/STR.text = str(int(active_str))
	$Panel/VBoxContainer/HBoxContainer/Stats/Numbers/ClassNum/HP.text = str(int(active_hp))
	$Panel/VBoxContainer/HBoxContainer/Stats/Numbers/ClassNum/DEF.text = str(int(active_def))
	$Panel/VBoxContainer/HBoxContainer/Stats/Numbers/ClassNum/SPD.text = str(snapped(active_spd, 0.01))
	$Panel/VBoxContainer/HBoxContainer/Stats/Numbers/ClassNum/MANA.text = str(int(active_mana))
	
func set_passive_labels(passive_str, passive_hp, passive_def, passive_spd, passive_mana):
	$Panel/VBoxContainer/HBoxContainer/Stats/Numbers/PassiveNum/STR.text = str(int(passive_str))
	$Panel/VBoxContainer/HBoxContainer/Stats/Numbers/PassiveNum/HP.text = str(int(passive_hp))
	$Panel/VBoxContainer/HBoxContainer/Stats/Numbers/PassiveNum/DEF.text = str(int(passive_def))
	$Panel/VBoxContainer/HBoxContainer/Stats/Numbers/PassiveNum/SPD.text = str(snapped(passive_spd, 0.01))
	$Panel/VBoxContainer/HBoxContainer/Stats/Numbers/PassiveNum/MANA.text = str(int(passive_mana))
	
func set_other_descriptions() -> void:
	$Panel/VBoxContainer/HBoxContainer/Abilities/AbilityInfo.init_update(class_id, current_ability_level)
	$Panel/VBoxContainer/HBoxContainer/Stats/Upgrade.disabled = !_check_upgrade_avaliability()
	$Panel/VBoxContainer/HBoxContainer/Abilities/Upgrade.disabled = !_check_ability_avaliability()
	
func _check_upgrade_avaliability():
	gold_upgrade_price = int(floor((10 * current_level)**1.3))
	requires_label_ref.text = str(gold_upgrade_price)
	if PlayerStats.Gold >= gold_upgrade_price:
		return true
	else:
		return false
func _check_ability_avaliability():
	if current_ability_level <5:
		orb_upgrade_price = int(floor((2 * current_ability_level)**1.3))
		ability_label_ref.text = str(orb_upgrade_price)
		if PlayerStats.Orbs >= orb_upgrade_price:
			return true
		else:
			return false
	else:
		$Panel/VBoxContainer/HBoxContainer/Abilities/Upgrade/Label.text = "Maxxed!"
		return false
func _on_talk_pressed():
	hide_menu_top()
	match current_class:
		"Warrior":
			$"../Tavern BG/Class_NPCS/Warrior_NPC".selected = -1
			$"../Tavern BG/Class_NPCS/Warrior_NPC"._send_conversation()
		"Rogue":
			$"../Tavern BG/Class_NPCS/Rogue_NPC".selected = -1
			$"../Tavern BG/Class_NPCS/Rogue_NPC"._send_conversation()
		"Mage":
			$"../Tavern BG/Class_NPCS/Mage_NPC".selected = -1
			$"../Tavern BG/Class_NPCS/Mage_NPC"._send_conversation()
	await dialogue_ref.message_complete
	show_menu()


func _on_upgrade_pressed():
	PlayerStats.Gold -= gold_upgrade_price
	match current_class:
		"Warrior":
			$"../Tavern BG/Class_NPCS/Warrior_CLASS_NPC".Class_Level += 1
			$"../Tavern BG/Class_NPCS/Warrior_CLASS_NPC".update_sheet()
		"Rogue":
			$"../Tavern BG/Class_NPCS/Rogue_CLASS_NPC".Class_Level += 1
			$"../Tavern BG/Class_NPCS/Rogue_CLASS_NPC".update_sheet()
		"Mage":
			$"../Tavern BG/Class_NPCS/Mage_CLASS_NPC".Class_Level += 1
			$"../Tavern BG/Class_NPCS/Mage_CLASS_NPC".update_sheet()
	$Panel/VBoxContainer/HBoxContainer/Stats/Upgrade.disabled = !_check_upgrade_avaliability()
func _on_upgrade_ability_pressed():
	PlayerStats.Orbs -= orb_upgrade_price
	current_ability_level += 1
	match current_class:
		"Warrior":
			$"../Tavern BG/Class_NPCS/Warrior_CLASS_NPC".Class_Ability_Level += 1
			$"../Tavern BG/Class_NPCS/Warrior_CLASS_NPC".update_sheet()
			match $"../Tavern BG/Class_NPCS/Warrior_CLASS_NPC".Class_Ability_Level:
				1:
					hide_menu_top()
					$"../Tavern BG/Class_NPCS/Warrior_NPC".selected = 3
					$"../Tavern BG/Class_NPCS/Warrior_NPC"._send_conversation()
					await dialogue_ref.message_complete
					show_menu()
				3:
					hide_menu_top()
					$"../Tavern BG/Class_NPCS/Warrior_NPC".selected = 4
					$"../Tavern BG/Class_NPCS/Warrior_NPC"._send_conversation()
					await dialogue_ref.message_complete
					show_menu()
				5:
					hide_menu_top()
					$"../Tavern BG/Class_NPCS/Warrior_NPC".selected = 5
					$"../Tavern BG/Class_NPCS/Warrior_NPC"._send_conversation()
					await dialogue_ref.message_complete
					show_menu()
		"Rogue":
			$"../Tavern BG/Class_NPCS/Rogue_CLASS_NPC".Class_Ability_Level += 1
			$"../Tavern BG/Class_NPCS/Rogue_CLASS_NPC".update_sheet()
			match $"../Tavern BG/Class_NPCS/Rogue_CLASS_NPC".Class_Ability_Level:
				1:
					hide_menu_top()
					$"../Tavern BG/Class_NPCS/Rogue_NPC".selected = 3
					$"../Tavern BG/Class_NPCS/Rogue_NPC"._send_conversation()
					await dialogue_ref.message_complete
					show_menu()
				3:
					hide_menu_top()
					$"../Tavern BG/Class_NPCS/Rogue_NPC".selected = 4
					$"../Tavern BG/Class_NPCS/Rogue_NPC"._send_conversation()
					await dialogue_ref.message_complete
					show_menu()
				5:
					hide_menu_top()
					$"../Tavern BG/Class_NPCS/Rogue_NPC".selected = 5
					$"../Tavern BG/Class_NPCS/Rogue_NPC"._send_conversation()
					await dialogue_ref.message_complete
					show_menu()
		"Mage":
			$"../Tavern BG/Class_NPCS/Mage_CLASS_NPC".Class_Ability_Level += 1
			$"../Tavern BG/Class_NPCS/Mage_CLASS_NPC".update_sheet()
			match $"../Tavern BG/Class_NPCS/Mage_CLASS_NPC".Class_Ability_Level:
				1:
					hide_menu_top()
					$"../Tavern BG/Class_NPCS/Mage_NPC".selected = 3
					$"../Tavern BG/Class_NPCS/Mage_NPC"._send_conversation()
					await dialogue_ref.message_complete
					show_menu()
				3:
					hide_menu_top()
					$"../Tavern BG/Class_NPCS/Mage_NPC".selected = 4
					$"../Tavern BG/Class_NPCS/Mage_NPC"._send_conversation()
					await dialogue_ref.message_complete
					show_menu()
				5:
					hide_menu_top()
					$"../Tavern BG/Class_NPCS/Mage_NPC".selected = 5
					$"../Tavern BG/Class_NPCS/Mage_NPC"._send_conversation()
					await dialogue_ref.message_complete
					show_menu()
	$Panel/VBoxContainer/HBoxContainer/Abilities/Upgrade.disabled = !_check_ability_avaliability()
	$Panel/VBoxContainer/HBoxContainer/Abilities/AbilityInfo.update_abilities(current_ability_level)

func _on_back_pressed():
	back_pressed.emit()
	hide_menu()
	set_top_right_button("Close")

func set_top_right_button(new_button: String):
	match new_button:
		"Back":
			$Panel/Back.show()
			$Panel/Close.hide()
		"Close":
			await get_tree().create_timer(1).timeout
			$Panel/Back.hide()
			$Panel/Close.show()
	


func _on_close_pressed() -> void:
	on_menu_left.emit()
	hide_menu()

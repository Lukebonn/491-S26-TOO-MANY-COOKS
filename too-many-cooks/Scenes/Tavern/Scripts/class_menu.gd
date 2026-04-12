extends Control
var is_showing = false
@export var dialogue_ref : Control
var current_class : String
var current_level

@onready var requires_label_ref = $Panel/VBoxContainer/HBoxContainer/Buttons/HBoxContainer/Label

signal back_pressed

func show_menu():
	is_showing = true
	$Panel/VBoxContainer/HBoxContainer/Buttons/HBoxContainer/Upgrade.disabled = !_check_upgrade_avaliability()
	var tween = get_tree().create_tween()
	tween.tween_property(self,"position",Vector2(self.position.x,320),.5).set_trans(Tween.TRANS_CUBIC)
	is_showing = true
	

func hide_menu():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"position",Vector2(self.position.x,1000),.5).set_trans(Tween.TRANS_CUBIC)
	await tween.finished
	current_class = ""
	is_showing = false

func hide_menu_top():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"position",Vector2(self.position.x,-1000),.5).set_trans(Tween.TRANS_CUBIC)

func set_title(new_name, level):
	$Panel/VBoxContainer/Class_Name.text = "The "
	$Panel/VBoxContainer/Class_Name.text += str(new_name)
	$Panel/VBoxContainer/Class_Name.text += ", Level " + str(level)
	current_class = new_name
	current_level = level
	
func set_active_labels(active_str, active_hp, active_def, active_spd, active_mana):
	$Panel/VBoxContainer/HBoxContainer/Stats/ActiveStatsNumbers/STR.text = str(int(active_str))
	$Panel/VBoxContainer/HBoxContainer/Stats/ActiveStatsNumbers/HP.text = str(int(active_hp))
	$Panel/VBoxContainer/HBoxContainer/Stats/ActiveStatsNumbers/DEF.text = str(int(active_def))
	$Panel/VBoxContainer/HBoxContainer/Stats/ActiveStatsNumbers/SPD.text = str(int(active_spd))
	$Panel/VBoxContainer/HBoxContainer/Stats/ActiveStatsNumbers/MANA.text = str(int(active_mana))
	
func set_passive_labels(passive_str, passive_hp, passive_def, passive_spd, passive_mana):
	$Panel/VBoxContainer/HBoxContainer/Stats/PassiveStatsNumbers/STR.text = str(int(passive_str))
	$Panel/VBoxContainer/HBoxContainer/Stats/PassiveStatsNumbers/HP.text = str(int(passive_hp))
	$Panel/VBoxContainer/HBoxContainer/Stats/PassiveStatsNumbers/DEF.text = str(int(passive_def))
	$Panel/VBoxContainer/HBoxContainer/Stats/PassiveStatsNumbers/SPD.text = str(int(passive_spd))
	$Panel/VBoxContainer/HBoxContainer/Stats/PassiveStatsNumbers/MANA.text = str(int(passive_mana))
	
func set_other_descriptions(attack_des, dash_des, magic_des, other_des):
	$Panel/VBoxContainer/HBoxContainer/Stats/AttackDescription.text = "Attack becomes a [color=red]"
	$Panel/VBoxContainer/HBoxContainer/Stats/DashDescription.text = "Dash becomes a [color=yellow]"
	$Panel/VBoxContainer/HBoxContainer/Stats/MagicDescription.text = "Magic becomes a [color=lightblue]"
	$Panel/VBoxContainer/HBoxContainer/Stats/TrueOtherDescription.text = ""
	$Panel/VBoxContainer/HBoxContainer/Stats/AttackDescription.text += str(attack_des)
	$Panel/VBoxContainer/HBoxContainer/Stats/DashDescription.text += str(dash_des)
	$Panel/VBoxContainer/HBoxContainer/Stats/MagicDescription.text += str(magic_des)
	$Panel/VBoxContainer/HBoxContainer/Stats/TrueOtherDescription.text += str(other_des)
	_check_upgrade_avaliability()
	
func _check_upgrade_avaliability():
	match current_class:
		"Warrior":
			match current_level:
				5: 
					requires_label_ref.text = "Requires 150 KOs!"
					if PlayerStats.KillCount > 150: 
						return true
				4: 
					requires_label_ref.text = "Requires 80 KOs!"
					if PlayerStats.KillCount > 80: 
						return true
				3: 
					requires_label_ref.text = "Requires 50 KOs!"
					if PlayerStats.KillCount > 50: 
						return true
				2:
					requires_label_ref.text = "Requires 25 KOs!"
					if PlayerStats.KillCount > 25: 
						return true
				1:
					requires_label_ref.text = "Requires 10 KOs!"
					if PlayerStats.KillCount > 10: 
						return true
				0:
					if PlayerStats.KillCount > -1: 
						requires_label_ref.text = "Free!"
						return true

		"Rogue":
			match current_level:
				0:
					if PlayerStats.Gold > -1: return true
				1:
					if PlayerStats.Gold > 3: return true
		"Mage":
			match current_level:
				5:
					requires_label_ref.text = "Requires 20 orbs!"
					if PlayerStats.Orbs > 20: 
						return true
				4:
					requires_label_ref.text = "Requires 10 orbs!"
					if PlayerStats.Orbs > 10: 
						return true
				3:
					requires_label_ref.text = "Requires 5 orbs!"
					if PlayerStats.Orbs > 5: 
						return true
				2:
					requires_label_ref.text = "Requires 3 orbs!"
					if PlayerStats.Orbs > 3: 
						return true
				1:
					requires_label_ref.text = "Requires 1 orb!"
					if PlayerStats.Orbs > 1: 
						return true
				0:
					requires_label_ref.text = "Free!"
					if PlayerStats.Orbs > -1: 
						return true

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
	$Panel/VBoxContainer/HBoxContainer/Buttons/HBoxContainer/Upgrade.disabled = !_check_upgrade_avaliability()


func _on_quest_pressed():
	hide_menu_top()
	match current_class:
		"Warrior":
			$"../Tavern BG/Class_NPCS/Warrior_NPC".selected = 2
			$"../Tavern BG/Class_NPCS/Warrior_NPC"._send_conversation()
			Global.Has_Warrior_Quest_1 = true
		"Rogue":
			$"../Tavern BG/Class_NPCS/Rogue_NPC".selected = 2
			$"../Tavern BG/Class_NPCS/Rogue_NPC"._send_conversation()
		"Mage":
			$"../Tavern BG/Class_NPCS/Mage_NPC".selected = 2
			$"../Tavern BG/Class_NPCS/Mage_NPC"._send_conversation()
			Global.Has_Mage_Quest_1 = true
	await dialogue_ref.message_complete
	show_menu()

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
	

extends Control

var direction = 0
@export var scroll_speed = 300.0
@export var dialogue_box_ref : Control
@export var class_menu_ref : Control
@export var act_select_ref : Control
@export var class_select_ref : Control
# Called when the node enters the scene tree for the first time.
func _ready():
	set_up_tavern()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dialogue_box_ref.in_dialogue == false and class_menu_ref.is_showing == false and act_select_ref.is_showing == false and class_select_ref.is_showing == false:
		position.x = position.x + (direction * scroll_speed * delta)
		position.x = clamp(position.x,-2304.0,0.0)
	if Input.is_action_just_pressed("debug_gold"):
		PlayerStats.Gold += 10
	if Input.is_action_just_pressed("debug_orbs"):
		PlayerStats.Orbs += 1
func _on_left_panel_mouse_entered():
	#lerp it to -1
	if !Global.First_Time_Tavern:
		var tween = get_tree().create_tween()
		tween.tween_property(self,"direction",10,1).set_trans(Tween.TRANS_CUBIC)
func _on_right_panel_mouse_entered():
	if !Global.First_Time_Tavern:
		var tween = get_tree().create_tween()
		tween.tween_property(self,"direction",-10,1).set_trans(Tween.TRANS_CUBIC)
func _either_panel_mouse_exited():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"direction",0,1).set_trans(Tween.TRANS_CUBIC)


func set_up_tavern():
	if PlayerStats.Magic == "Fireball":
		$TavernBackgroundLong.hide()
		$TavernBackgroundLong2.show()
	if Global.Has_Finished_Playtest:
		$ROGUE.show()
		$PLAYTEST.show()
		$"Upgrade Man/NPCMagic".hide()
		$"Upgrade Man/NPCEnd".hide()
		$TavernBackgroundLong2.hide()
		$TavernBackgroundLong3.show()
		$"EndDoor".show()
	if Global.Has_Mage_NPC:
		$Class_NPCS/Mage_CLASS_NPC.show()
		$"Upgrade Man/MagicWorkshop0".hide()
		$TavernBackgroundLong2.show()
	if Global.Has_Rogue_NPC:
		$Class_NPCS/Rogue_CLASS_NPC.show()
		$"Upgrade Man/RogueWorkshop0".hide()
	if Global.Act_3_Unlocked:
		$TavernBackgroundLong3.show()

func _on_door_andy_pressed():
	class_select_ref.show_menu()
	$Exit.disabled = true


func _on_end_door_pressed():
	print("Thanks for playing what we have so far!")
	get_tree().change_scene_to_file("res://play_test_end.tscn")


func _on_class_select_class_checked(name_of_class):
	match name_of_class:
		"Warrior":
			$Class_NPCS/Warrior_CLASS_NPC._on_clicked()
		"Rogue":
			$Class_NPCS/Rogue_CLASS_NPC._on_clicked()
		"Mage":
			$Class_NPCS/Mage_CLASS_NPC._on_clicked()
	class_menu_ref.set_top_right_button("Back")
	class_select_ref.hide_menu_top()


func _on_class_select_class_selected(name_of_class):
	match name_of_class:
		"Warrior":
			$Class_NPCS/Warrior_CLASS_NPC.change_class(name_of_class)
		"Rogue":
			$Class_NPCS/Rogue_CLASS_NPC.change_class(name_of_class)
		"Mage":
			$Class_NPCS/Mage_CLASS_NPC.change_class(name_of_class)
	class_select_ref.hide_menu_top()
	act_select_ref.show_menu()


func _on_class_menu_back_pressed():
	class_select_ref.show_menu()
	

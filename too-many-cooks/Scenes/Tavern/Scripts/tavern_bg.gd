extends Control

var direction = 0
@export var scroll_speed = 300.0
@export var dialogue_box_ref : Control
@export var class_menu_ref : Control
# Called when the node enters the scene tree for the first time.
func _ready():
	set_up_tavern()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dialogue_box_ref.in_dialogue == false and class_menu_ref.is_showing == false:
		position.x = position.x + (direction * scroll_speed * delta)
		position.x = clamp(position.x,-2304.0,0.0)
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
		$RANGER.show()
		$PLAYTEST.show()
		$"Upgrade Man/NPCMagic".hide()
		$"Upgrade Man/NPCEnd".hide()
		$TavernBackgroundLong2.hide()
		$TavernBackgroundLong3.show()
		$"Door Andy".queue_free()
		$"EndDoor".show()
func _on_door_andy_pressed():
	print("leaving...")
	get_tree().change_scene_to_file("res://Scenes/Test/PlayerEnemyTest/combat_test.tscn")


func _on_end_door_pressed():
	print("Thanks for playing what we have so far!")
	get_tree().change_scene_to_file("res://play_test_end.tscn")

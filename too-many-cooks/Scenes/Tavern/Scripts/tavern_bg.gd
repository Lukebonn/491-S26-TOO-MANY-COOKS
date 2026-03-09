extends Control

var direction = 0
@export var scroll_speed = 300.0
# Called when the node enters the scene tree for the first time.
func _ready():
	set_up_tavern()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $"..".in_dialogue == false:
		position.x = position.x + (direction * scroll_speed * delta)
		position.x = clamp(position.x,-2304.0,0.0)
func _on_left_panel_mouse_entered():
	#lerp it to -1
	var tween = get_tree().create_tween()
	tween.tween_property(self,"direction",10,1).set_trans(Tween.TRANS_CUBIC)
func _on_right_panel_mouse_entered():
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
		
func _on_door_andy_pressed():
	print("leaving...")
	get_tree().change_scene_to_file("res://Scenes/Test/PlayerEnemyTest/combat_test.tscn")

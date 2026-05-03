extends Control
var is_showing = false
var allow_input = true

# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.Act_2_Unlocked:
		$Panel/VBoxContainer/MarginContainer2/Levels/Act2.disabled = false
	if Global.Act_3_Unlocked:
		$Panel/VBoxContainer/MarginContainer2/Levels/Act3.disabled = false

func _on_close_pressed():
	hide_menu()

func show_menu():
	is_showing = true
	$Container.show()
	var tween = get_tree().create_tween()
	tween.tween_property(self,"position",Vector2(self.position.x,320),.5).set_trans(Tween.TRANS_CUBIC)
	is_showing = true

func hide_menu():
	var tween = get_tree().create_tween()
	$Container.hide()
	tween.tween_property(self,"position",Vector2(self.position.x,1000),.5).set_trans(Tween.TRANS_CUBIC)
	await tween.finished
	is_showing = false

func hide_menu_top():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"position",Vector2(self.position.x,-1000),.5).set_trans(Tween.TRANS_CUBIC)
	is_showing = false

#Act buttons clicked; make respective level queues.
func _on_act_1_pressed():
	make_level_queue("res://Scenes/Level Design/Playtest3LevelPack/Act 1",3, 1)
func _on_act_2_pressed():
	make_level_queue("res://Scenes/Level Design/Playtest3LevelPack/Act 2",4, 2)
func _on_act_3_pressed():
	make_level_queue("res://Scenes/Level Design/Playtest3LevelPack/Act 1",5, 3)

func make_level_queue(dir: String, amount : int, act: int):
	if allow_input:
		allow_input = false
		var files = DirAccess.get_files_at(dir)
		var levels: Array = []
		for file in files:
			file = dir + "/" + file
			if file.right(5) == ".tscn" or "remap":
				levels.append(file)
		var indicies_queued: Array = []
		print(files)
		while LevelQueue.Queue.size() < amount-1:
			var rng = randi_range(0,(levels.size()-1))
			if rng not in indicies_queued:
				var new_level = levels.get(rng)
				LevelQueue.Queue.append(new_level)
				print(new_level + " was not in level queue, adding it")
				indicies_queued.append(rng) 
			else:
				print("attempted level was in the level queue already")
				print(LevelQueue.Queue.size())
				await get_tree().process_frame
		match act:
			1:
				LevelQueue.Queue.append("res://Scenes/Level Design/Playtest3LevelPack/Bosses/Level1BossRoom.tscn")
			2:
				LevelQueue.Queue.append("res://Scenes/Level Design/Playtest3LevelPack/Bosses/Level2BossRoom.tscn")
			3:
				LevelQueue.Queue.append("res://Scenes/Level Design/Playtest3LevelPack/Bosses/Level3BossRoom.tscn")
		print("Level queue is... " + str(LevelQueue.Queue))
		LevelQueue.load_level()

func _on_practice_pressed():
	LevelQueue.Queue.append("res://Scenes/Level Design/Playtest3LevelPack/Practice.tscn")
	LevelQueue.load_level()

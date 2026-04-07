extends Control
var is_showing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_close_pressed():
	hide_menu()

func show_menu():
	is_showing = true
	var tween = get_tree().create_tween()
	tween.tween_property(self,"position",Vector2(self.position.x,320),.5).set_trans(Tween.TRANS_CUBIC)
	is_showing = true

func hide_menu():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"position",Vector2(self.position.x,1000),.5).set_trans(Tween.TRANS_CUBIC)
	await tween.finished
	is_showing = false

func hide_menu_top():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"position",Vector2(self.position.x,-1000),.5).set_trans(Tween.TRANS_CUBIC)
	is_showing = false

func _on_act_1_pressed():
	#later hook this up to a level queue that picks N unique levels out of the scenes in a given folder
	make_level_queue("res://Scenes/Level Design/Level Jam/",3)
	pass # Replace with function body.


func _on_act_2_pressed():
	pass # Replace with function body.


func _on_act_3_pressed():
	pass # Replace with function body.
	
func make_level_queue(dir: String, amount : int):
	var files = DirAccess.get_files_at(dir)
	var levels: Array = []
	for file in files:
		file = dir + "/" + file
		if file.right(5) == ".tscn" or "remap":
			levels.append(file)
	var indicies_queued: Array = []
	print(files)
	while LevelQueue.Queue.size() < amount:
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
	LevelQueue.load_level()
		
		

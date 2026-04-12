extends Node
#this guy tracks the next level to load when loading a level

var Queue : Array = []

func load_level() -> void:
	#Save current Gold to temporary value.
	PlayerStats.temp_gold = PlayerStats.Gold
	if Queue.size() != 0:
		FadeInFadeOut.fade_out()
		await get_tree().create_timer(1).timeout
		var level = str(Queue.pop_front())
		if level.contains(".remap"):
			level = level.replace(".remap","")
		get_tree().change_scene_to_file(level)
	else:
		FadeInFadeOut.fade_out()
		await get_tree().create_timer(1).timeout
		get_tree().change_scene_to_file("res://Scenes/Tavern/tavern.tscn")
	
	FadeInFadeOut.fade_in()

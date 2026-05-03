extends Node2D

func _on_obj_enemy_spawner_on_all_dead():
	pass

func _on_rat_king_on_enemy_death():
	if $Player.health > 0:
		await get_tree().create_timer(3).timeout
		FadeInFadeOut.fade_out()
		await get_tree().create_timer(1.2).timeout
		get_tree().change_scene_to_file("res://Scenes/Intro Cutscene/outro_cutscene.tscn")

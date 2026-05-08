extends Node2D
@export var dialogue_ref : Control
@export var ambientMusic: AudioStreamPlayer
@export var actionMusic: AudioStreamPlayer

var deadRats = 0

func _ready():
	FadeInFadeOut.fade_in()
	if ambientMusic:
		ambientMusic.play()


func _on_player_player_death():
	dialogue_ref.show_dialogue("Gramps","0,1,2,3","0,0")
	await dialogue_ref.message_complete
	FadeInFadeOut.fade_out()
	await get_tree().create_timer(1.2).timeout
	var target_scene = ResourceLoader.load("uid://bflr35recnny2")
	get_tree().change_scene_to_packed(target_scene)


#func _on_first_guy_all_enemies_dead():
	#if ambientMusic:
		#ambientMusic.stop()
	#await get_tree().create_timer(0.5).timeout
	#if actionMusic:
		#actionMusic.play()
	#$"Insta-KO Squad".process_mode = Node.PROCESS_MODE_INHERIT
	#for node in $"Insta-KO Squad".get_children():
		#node.show()

func _on_first_rat_death() -> void:
	if ambientMusic and actionMusic:
		ambientMusic.stop()
		actionMusic.play()
	await get_tree().create_timer(0.1).timeout
	#$"Insta-KO Squad".process_mode = Node.PROCESS_MODE_INHERIT
	for node in $"Insta-KO Squad".get_children():
		node.process_mode = Node.PROCESS_MODE_ALWAYS
		node.show()
		await get_tree().create_timer(1).timeout


func _on_tutorial_rat_enemy_death() -> void:
	deadRats += 1
	if deadRats == 8:
		if actionMusic:
			actionMusic.stop()
		$Player.process_mode = Node.PROCESS_MODE_DISABLED
		dialogue_ref.show_dialogue("Player","0,1,2,3", "0,0")
		await dialogue_ref.message_complete
		$Player.hide()
		dialogue_ref.show_dialogue("Narrator","0,1,2,3,4", "0,0")
		await dialogue_ref.message_complete
		FadeInFadeOut.fade_out()
		await get_tree().create_timer(1.2).timeout
		get_tree().change_scene_to_file("res://UI/Credits/credits.tscn")

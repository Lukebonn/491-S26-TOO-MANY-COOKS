extends Node2D
@export var dialogue_ref : Control
func _ready():
	FadeInFadeOut.fade_in()
	
func _on_player_player_death():
	dialogue_ref.show_dialogue("Gramps","0,1","0,0")
	await dialogue_ref.message_complete
	FadeInFadeOut.fade_out()
	await get_tree().create_timer(1.2).timeout
	var target_scene = ResourceLoader.load("uid://bflr35recnny2")
	get_tree().change_scene_to_packed(target_scene)


func _on_first_guy_all_enemies_dead():
	$"Insta-KO Squad".process_mode = Node.PROCESS_MODE_INHERIT
	for node in $"Insta-KO Squad".get_children():
		node.show()

extends Control
# Carson made this so yell at her if you want something different

var can_start_game = false
var selected = false

signal stop_spinning_enivonment

# Called when the node enters the scene tree for the first time.
func _ready():
	title_cinematics_gogogo()

func _input(_event):
	if Input.is_anything_pressed() and can_start_game:
		can_start_game = false
		cast_aside_title_and_get_to_menu()
		stop_spinning_enivonment.emit()

func title_cinematics_gogogo():
	var tween = get_tree().create_tween()
	tween.tween_property($titletop/MarginContainer,"theme_override_constants/margin_top",40,1.0).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property($titlebottom/MarginContainer,"theme_override_constants/margin_top",-80,1.0).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	await get_tree().create_timer(2.0).timeout
	can_start_game = true

func cast_aside_title_and_get_to_menu():
	var tween = get_tree().create_tween()
	tween.parallel().tween_property($titletop/MarginContainer,"position",Vector2(-530,0),.5).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property($titlebottom/MarginContainer,"position",Vector2(-1200,0),.3).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)


func _on_quit_button_down():
	if not selected:
		selected = true
		get_tree().quit()


func _on_start_pressed():
	if not selected:
		selected = true
		FadeInFadeOut.fade_out()
		await get_tree().create_timer(1.2).timeout
		get_tree().change_scene_to_file("res://Scenes/Intro Cutscene/intro_cutscene.tscn")


func _on_continue_pressed():
	if not selected:
		selected = true
		Global.First_Time_Tavern = true
		Global.First_Time_Combat = false
		get_tree().change_scene_to_file("res://Scenes/Tavern/tavern.tscn")


func _on_credits_pressed() -> void:
	if not selected:
		selected = true
		FadeInFadeOut.fade_out()
		await get_tree().create_timer(1.2).timeout
		get_tree().change_scene_to_file("res://UI/Credits/credits.tscn")

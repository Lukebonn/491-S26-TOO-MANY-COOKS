extends VBoxContainer

##The y position to tween to. May have to experiment for precise, good-looking value.
@export var TweenTarget : float = 0.0
##The time spent tweening the Credits UI.
@export var TweenTime : float = 10.0

func _ready() -> void:
	FadeInFadeOut.fade_in()
	var tween = get_tree().create_tween()
	tween.tween_property(self,"position",Vector2(0,TweenTarget),TweenTime).set_trans(Tween.TRANS_LINEAR)
	#await tween.finished
	#wait_and_fade()
#
#func wait_and_fade() -> void:
	#await get_tree().create_timer(3.0).timeout
	#FadeInFadeOut.fade_out()
	#await get_tree().create_timer(1.2).timeout
	#get_tree().change_scene_to_file("res://Scenes/Title/title_screen.tscn")

# Above code waits then fades back to title.
# Commented out in case we want the Credits UI to just show in title on top of background.

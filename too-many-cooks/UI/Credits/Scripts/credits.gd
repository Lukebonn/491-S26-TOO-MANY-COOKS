extends VBoxContainer

##The y position to tween to. May have to experiment for precise, good-looking value.
@export var TweenTarget : float = 0.0
##The time spent tweening the Credits UI.
@export var TweenTime : float = 10.0

#Whether or not we're already fading back to title.
var fading : bool = false

# Begin pan, wait for pan to finish, wait extra "linger" time, then try fading to title.
func _ready() -> void:
	FadeInFadeOut.fade_in()
	var tween = get_tree().create_tween()
	tween.tween_property(self,"position",Vector2(0,TweenTarget),TweenTime).set_trans(Tween.TRANS_LINEAR)
	await tween.finished
	await get_tree().create_timer(3.0).timeout
	try_fade()

# Allows for skipping Credits if any key is pressed.
func _process(_delta: float) -> void:
	if Input.is_anything_pressed() and not fading:
		try_fade()

# Attempt to fade back to title, if not already fading.
func try_fade() -> void:
	if not fading:
		fading = true
		FadeInFadeOut.fade_out()
		await get_tree().create_timer(1.2).timeout
		FadeInFadeOut.fade_in()
		get_tree().change_scene_to_file("res://Scenes/Title/title_screen.tscn")

# Above code waits then fades back to title.
# Commented out in case we want the Credits UI to just show in title on top of background.
#nah we want this so im uncommenting it
# Sora Kingdom Hearts using an item: Okay!

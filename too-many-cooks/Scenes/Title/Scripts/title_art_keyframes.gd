extends Control
var entered_title_screen : bool = false
func _ready():
	forever_lerp_part(2)

func _on_title_ui_stop_spinning_enivonment():
	entered_title_screen = true
	var tween = self.create_tween().set_parallel(true)
	tween.tween_property($"4","position",Vector2(0,0),3.0).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property($"6","position",Vector2(0,0),3.3).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property($"7","position",Vector2(0,0),3.6).set_trans(Tween.TRANS_CUBIC)

func forever_lerp_part(ind:int):
	if entered_title_screen == false:
		var moving = get_child(ind)
		var tween = self.create_tween()
		tween.tween_property(moving,"position",Vector2(0,50),10.0)
		tween.tween_property(moving,"position",Vector2(0,0),10.0)
		await tween.finished
		forever_lerp_part(ind)

	

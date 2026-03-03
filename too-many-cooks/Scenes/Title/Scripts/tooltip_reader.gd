extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_master_audio_mouse_entered():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"text","Control all audio",.1).set_trans(Tween.TRANS_CUBIC)

func _on_music_audio_mouse_entered():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"text","Control music",.1).set_trans(Tween.TRANS_CUBIC)
	
func _on_sfx_audio_mouse_entered():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"text","Control sound effects",.1).set_trans(Tween.TRANS_CUBIC)

func _on_fullscreen_mouse_entered():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"text","Toggle fullscreen (Unavailable on web)",.1).set_trans(Tween.TRANS_CUBIC)


func _on_purple_toggle_mouse_entered():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"text","Make him purple",.1).set_trans(Tween.TRANS_CUBIC)

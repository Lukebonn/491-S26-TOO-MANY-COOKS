extends RichTextLabel
@export var clickSound : AudioStreamPlayer
@export var hoverSound : AudioStreamPlayer

func _on_master_audio_mouse_entered():
	var tween = get_tree().create_tween()
	hoverSound.play()
	tween.tween_property(self,"text","Change the volume for all game audio.",.1).set_trans(Tween.TRANS_CUBIC)

func _on_music_audio_mouse_entered():
	var tween = get_tree().create_tween()
	hoverSound.play()
	tween.tween_property(self,"text","Change the volume for background music.",.1).set_trans(Tween.TRANS_CUBIC)
	
func _on_sfx_audio_mouse_entered():
	var tween = get_tree().create_tween()
	hoverSound.play()
	tween.tween_property(self,"text","Change the volume for sound effects.",.1).set_trans(Tween.TRANS_CUBIC)

func _on_fullscreen_mouse_entered():
	var tween = get_tree().create_tween()
	hoverSound.play()
	tween.tween_property(self,"text","Toggle fullscreen (Unavailable on web).",.1).set_trans(Tween.TRANS_CUBIC)


func _on_purple_toggle_mouse_entered():
	var tween = get_tree().create_tween()
	hoverSound.play()
	tween.tween_property(self,"text","Make him purple",.1).set_trans(Tween.TRANS_CUBIC)


func _on_minimap_toggle_mouse_entered() -> void:
	var tween = get_tree().create_tween()
	hoverSound.play()
	tween.tween_property(self,"text","Toggle visibility of the Combat Minimap.",.1).set_trans(Tween.TRANS_CUBIC)


func _on_time_toggle_mouse_entered() -> void:
	var tween = get_tree().create_tween()
	hoverSound.play()
	tween.tween_property(self,"text","Toggle visibility of the Level Timer.",.1).set_trans(Tween.TRANS_CUBIC)

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
	print("entermaster")

func _on_music_audio_mouse_entered():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"text","Control music",.1).set_trans(Tween.TRANS_CUBIC)
	print("entermusic")
	
func _on_sfx_audio_mouse_entered():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"text","Control sound effects",.1).set_trans(Tween.TRANS_CUBIC)
	print("entersfx")

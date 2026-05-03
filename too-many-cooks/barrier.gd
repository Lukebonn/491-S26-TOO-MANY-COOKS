extends StaticBody2D
var player = null

func _on_area_2d_area_entered(area: Area2D):
	player = area
	if(player):
		$CollisionShape2D.set_deferred("disabled", true)
		$Area2D/CollisionShape2D.set_deferred("disabled", true)
		hide()
		$AudioStreamPlayer.play()
		await $AudioStreamPlayer.finished
		


func _on_audio_stream_player_finished():
	queue_free()

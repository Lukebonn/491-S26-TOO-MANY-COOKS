extends Node

@export var Combat_Music : AudioStreamPlayer
@export var Death_Music : AudioStreamPlayer

func _ready() -> void:
	Combat_Music.play()


func _on_player_music_stop() -> void:
	Combat_Music.stop()
	Death_Music.play()

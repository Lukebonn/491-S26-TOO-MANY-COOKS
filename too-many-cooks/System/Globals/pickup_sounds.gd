extends Node

@export var Gold_Pickup_Sound: AudioStreamPlayer
@export var Orb_Pickup_Sound: AudioStreamPlayer

func play_gold_sound():
	Gold_Pickup_Sound.play()
	Gold_Pickup_Sound.pitch_scale = randf_range(0.90, 1.10)

func play_orb_sound():
	Orb_Pickup_Sound.play()

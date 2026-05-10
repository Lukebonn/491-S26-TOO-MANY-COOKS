extends Pickup
@export var Orb_Sound : AudioStreamPlayer

func collect(body):
	if body.name == "Player":
		PlayerStats.Orbs += Value
		PlayerStats.Floor_Orbs += Value
		print("Collected a " + Name)
		Orb_Sound.play()
		queue_free()

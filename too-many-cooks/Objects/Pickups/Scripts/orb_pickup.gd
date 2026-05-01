extends Pickup


func collect(body):
	if body.name == "Player":
		PlayerStats.Orbs += Value
		PlayerStats.Floor_Orbs += Value
		print("Collected a " + Name)
		queue_free()

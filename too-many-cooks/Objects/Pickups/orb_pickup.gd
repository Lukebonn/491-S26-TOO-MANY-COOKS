extends Pickup


func collect(_body):
	PlayerStats.Orbs += Value
	print("Collected a " + Name)
	queue_free()

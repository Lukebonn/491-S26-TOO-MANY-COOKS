extends Pickup

func collect(_body):
	PlayerStats.MaxMana += 10
	print("Collected a" + name)
	queue_free()

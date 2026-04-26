extends Pickup


func collect(body):
	if body.name == "Player":
		PlayerStats.Orbs += Value
		if Global.Has_Mage_Quest_1:
			PlayerStats.Quest1Orbs += 1
		print("Collected a " + Name)
		queue_free()

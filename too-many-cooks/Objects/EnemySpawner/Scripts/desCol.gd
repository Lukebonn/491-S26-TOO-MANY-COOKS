extends Area2D
#"desCol" = Destructable Enemy Spawner COLlision

#The initial HP of this Spawner.
var current_health : int
#Whether or not the Spawner is destroyed and shouldn't be able to be attacked.
var dead : bool = false

func take_damage(inc_damage: int):
	if not dead:
		current_health -= inc_damage
		var damage_number = preload("res://Characters/Enemies/Scenes/DamageNumber.tscn").instantiate()
		damage_number.Number = inc_damage
		add_child(damage_number)
		$HealthBar.value = current_health
		if current_health <= 0:
			dead = true
			$"..".destroy_spawner()

func _on_area_entered(area: Area2D) -> void:
	take_damage(area.get_parent().damage)

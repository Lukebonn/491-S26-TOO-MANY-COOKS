class_name Health

extends Node

@export var max_health : float

@export var health: float

func set_health (value: float):
	health += value
	if health > max_health:
		health = max_health
	
func heal (heal_amount: float):
	set_health(heal_amount)
	
func take_damage (damage: float):
	set_health(-damage)

extends EnemyState

#signal create_damage_area(playerX: float, playerY: float)
var damageArea = preload("res://Characters/Enemies/Rat King/RKDamageArea.tscn")


func enter_state(enemy_node):
	super(enemy_node)
	await get_tree().create_timer(1).timeout
	#create_damage_area.emit(player_ref.position.x, player_ref.position.y)
	var instance = damageArea.instantiate()
	add_sibling(instance)
	instance.position = player_ref.position - enemy_ref.position

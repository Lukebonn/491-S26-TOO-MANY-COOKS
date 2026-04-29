extends EnemyState

signal create_damage_area(playerX: float, playerY: float)

func enter_state(enemy_node):
	super(enemy_node)
	await get_tree().create_timer(1).timeout
	create_damage_area.emit(player_ref.position.x, player_ref.position.y)
	

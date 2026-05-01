extends EnemyState

var targeting = false
var projectile = preload("res://Characters/Enemies/Rat King/RKBasicProjectile.tscn")
signal fire_projectiles

func enter_state(enemy_node):
	super(enemy_node)
	targeting = true
	await get_tree().create_timer(3).timeout
	targeting = false
	fire_projectiles.emit()

func process(_delta):
	pass
	if targeting:
		if not enemy_ref.enraged:
			$"../RegularProjectileLines".look_at(Vector2(player_ref.position.x, player_ref.position.y))
		else:
			$"../EnragedProjectileLines".look_at(Vector2(player_ref.position.x, player_ref.position.y))

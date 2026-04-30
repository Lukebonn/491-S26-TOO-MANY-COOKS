extends EnemyState

var targeting = false
var projectile = preload("res://Characters/Enemies/Rat King/RKBasicProjectile.tscn")

func enter_state(enemy_node):
	super(enemy_node)
	$"../RegularProjectileLines".hide()
	$"../EnragedProjectileLines".hide()
	if not enemy_ref.enraged: $"../RegularProjectileLines".show()
	else: $"../EnragedProjectileLines".show()
	targeting = true
	await get_tree().create_timer(1.5).timeout
	targeting = false
	$"../RegularProjectileLines/Projectile Line1".target_position = Vector2(player_ref.position.x, player_ref.position.y - 56)
	$"../RegularProjectileLines/Projectile Line2".target_position = player_ref.position
	$"../RegularProjectileLines/Projectile Line3".target_position = Vector2(player_ref.position.x, player_ref.position.y + 56)
	var projectile1 = projectile.instantiate()
	projectile1.name = "1"
	add_child(projectile1)
	var projectile2 = projectile.instantiate()
	projectile2.name = "2"
	add_child(projectile2)
	var projectile3 = projectile.instantiate()
	projectile3.name = "3"
	add_child(projectile3)
	if enemy_ref.enraged:
		var projectile4 = projectile.instantiate()
		projectile4.name = "4"
		add_child(projectile4)
	projectile1.look_at(Vector2(player_ref.position.x, player_ref.position.y))
	#projectile1.position = lerp_move_to_target(player_ref.position)

func process(_delta):
	pass
	#if targeting:
		#if not enemy_ref.enraged:
			#$"../RegularProjectileLines".look_at(Vector2(player_ref.position.x, player_ref.position.y))
		#else:
			#$"../EnragedProjectileLines".look_at(Vector2(player_ref.position.x, player_ref.position.y))

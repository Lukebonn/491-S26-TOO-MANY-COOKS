extends EnemyState

var projectile = preload("res://Characters/Enemies/Rat King/RKHomingProjectile.tscn")
@export var state_to_enter: Node
@export var projectile_damage: int
@export var projectile_speed: int
@export var casting_time: float
@export var cooldown_time: float

func enter_state(enemy_node):
	super(enemy_node)
	enemy_node.get_node("AnimatedSprite2D").play("conjuring")
	await get_tree().create_timer(casting_time).timeout
	if enemy_ref.enraged:
		print(projectile_damage)
		for i in range(3):
			create_custom_projectile(projectile_damage + 10, projectile_speed + 50)
			await get_tree().create_timer(0.5).timeout
	else:
		create_projectile()
		#var projectile1 = projectile.instantiate()
		#projectile1.state_ref = self
		#projectile1.damage = projectile_damage
		#projectile1.enemy_ref = enemy_ref
		#projectile1.player_ref = player_ref
		#projectile1.projectile_speed = projectile_speed
		#add_sibling(projectile1)
		#projectile1.look_at(Vector2(player_ref.position.x, player_ref.position.y))
	enemy_node.get_node("AnimatedSprite2D").play("casting")
	await get_tree().create_timer(cooldown_time).timeout
	exit_state()

func exit_state():
	if enemy_ref.playerNear:
		enemy_ref.change_state("ShockwaveState")
	else:
		if state_to_enter:
			enemy_ref.change_state(str(state_to_enter))
		else:
			enemy_ref.change_state("IdleState")

func hit_response(source):
	pass

func create_projectile():
	var projectile1 = projectile.instantiate()
	projectile1.state_ref = self
	projectile1.damage = projectile_damage
	projectile1.enemy_ref = enemy_ref
	projectile1.player_ref = player_ref
	projectile1.projectile_speed = projectile_speed
	add_sibling(projectile1)
	projectile1.look_at(Vector2(player_ref.position.x, player_ref.position.y))

func create_custom_projectile(damage: int, speed: int):
	var projectile1 = projectile.instantiate()
	projectile1.state_ref = self
	projectile1.damage = damage
	projectile1.enemy_ref = enemy_ref
	projectile1.player_ref = player_ref
	projectile1.projectile_speed = speed
	add_sibling(projectile1)
	projectile1.look_at(Vector2(player_ref.position.x, player_ref.position.y))

extends EnemyState

var targeting = false
var projectile = preload("res://Characters/Enemies/Rat King/RKBasicProjectile.tscn")
signal fire_projectiles
@export var state_to_enter: Node
@export var projectile_damage: int
@export var casting_time: float
@export var cooldown_time: float

func enter_state(enemy_node):
	super(enemy_node)
	enemy_node.get_node("AnimatedSprite2D").play("conjuring")
	targeting = true
	$"../RegularProjectileLines/TempIndicators".show()
	await get_tree().create_timer(casting_time).timeout
	enemy_node.get_node("AnimatedSprite2D").play("casting")
	targeting = false
	$"../RegularProjectileLines/TempIndicators".hide()
	var projectile1 = projectile.instantiate()
	projectile1.state_ref = self
	projectile1.damage = projectile_damage
	$"../RegularProjectileLines/Path2D/Line1".add_child(projectile1)
	var projectile2 = projectile.instantiate()
	projectile2.state_ref = self
	projectile2.damage = projectile_damage
	$"../RegularProjectileLines/Path2D2/Line2".add_child(projectile2)
	var projectile3 = projectile.instantiate()
	projectile3.state_ref = self
	projectile3.damage = projectile_damage
	$"../RegularProjectileLines/Path2D3/Line3".add_child(projectile3)
	fire_projectiles.emit()
	await get_tree().create_timer(cooldown_time).timeout
	exit_state()

func exit_state():
	if state_to_enter:
		enemy_ref.change_state(str(state_to_enter))
	else:
		enemy_ref.change_state("IdleState")

func hit_response(source):
	pass

func process(_delta):
	if targeting:
		if not enemy_ref.enraged:
			$"../RegularProjectileLines".look_at(Vector2(player_ref.position.x, player_ref.position.y))
		else:
			$"../EnragedProjectileLines".look_at(Vector2(player_ref.position.x, player_ref.position.y))

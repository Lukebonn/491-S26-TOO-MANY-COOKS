extends EnemyState

#signal create_damage_area(playerX: float, playerY: float)
var damageArea = preload("res://Characters/Enemies/Rat King/RKDamageArea.tscn")
var targeting
@export var state_to_enter: Node
@export var area_damage: int
@export var max_size: float
@export var enrage_size_multiplier: float
@export var existence_time: float
@export var summon_time: float
@export var casting_time: float
@export var cooldown_time: float

func enter_state(enemy_node):
	super(enemy_node)
	enemy_node.get_node("AnimatedSprite2D").play("conjuring")
	targeting = true
	$"../AoEWarningZone".show()
	if enemy_ref.enraged:
		$"../AoEWarningZone".scale = Vector2(max_size * enrage_size_multiplier, max_size * enrage_size_multiplier)
	else:
		$"../AoEWarningZone".scale = Vector2(max_size, max_size)
	await get_tree().create_timer(casting_time).timeout
	targeting = false
	$"../AoEWarningZone".hide()
	enemy_node.get_node("AnimatedSprite2D").play("casting")
	#create_damage_area.emit(player_ref.position.x, player_ref.position.y)
	var instance
	if enemy_ref.enraged:
		instance = create_custom_aoe_zone(
			area_damage + 25,
			max_size * enrage_size_multiplier,
			existence_time + 1.0,
			summon_time - 0.5
		)
	else:
		instance = create_aoe_zone()
	add_sibling(instance)
	instance.position = player_ref.position - enemy_ref.position
	await get_tree().create_timer(cooldown_time).timeout
	exit_state()

func exit_state():
	if state_to_enter:
		enemy_ref.change_state(str(state_to_enter))
	else:
		enemy_ref.change_state("IdleState")

func hit_response(source):
	pass

func create_aoe_zone():
	var zone = damageArea.instantiate()
	zone.damage = area_damage
	zone.max_size = max_size
	zone.existence_time = existence_time
	zone.summon_time = summon_time
	return zone

func create_custom_aoe_zone(damage: int, size: float, existence_time: float, summon_time: float):
	var zone = damageArea.instantiate()
	zone.damage = damage
	zone.max_size = size
	zone.existence_time = existence_time
	zone.summon_time = summon_time
	return zone

func process(_delta):
	if targeting:
		$"../AoEWarningZone".position = player_ref.position - enemy_ref.position

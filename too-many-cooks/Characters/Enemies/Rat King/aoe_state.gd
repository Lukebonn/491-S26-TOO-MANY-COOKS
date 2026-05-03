extends EnemyState

#signal create_damage_area(playerX: float, playerY: float)
var damageArea = preload("res://Characters/Enemies/Rat King/RKDamageArea.tscn")
@export var state_to_enter: Node
@export var area_damage: int
@export var casting_time: float
@export var cooldown_time: float

func enter_state(enemy_node):
	super(enemy_node)
	enemy_node.get_node("AnimatedSprite2D").play("conjuring")
	await get_tree().create_timer(casting_time).timeout
	enemy_node.get_node("AnimatedSprite2D").play("casting")
	#create_damage_area.emit(player_ref.position.x, player_ref.position.y)
	var instance = damageArea.instantiate()
	instance.damage = area_damage
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

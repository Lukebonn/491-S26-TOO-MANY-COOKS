extends EnemyState
# Enemy swipes in the direction of the player, dealing damage.



@export var state_to_enter: Node
@export var damage: int
@export var enraged_damage: int
@export var casting_time: float
@export var persistence_time: float
@export var cooldown_time: float


func enter_state(enemy_node):
	super(enemy_node)
	enemy_node.get_node("AnimatedSprite2D").play("conjuring")
	if enemy_node.enraged:
		$"../ShockwaveHitbox".damage = enraged_damage
		
	else:
		$"../ShockwaveHitbox".damage = damage
	$"../ShockwaveHitbox".process_mode = Node.PROCESS_MODE_DISABLED
	$"../ShockwaveWarning".show()
	$"../ShockwaveWarning".modulate = Color(1, 0, 0, 0.40)
	await get_tree().create_timer(casting_time).timeout
	$"../ShockwaveWarning".modulate = Color(1, 0, 0, 1)
	$"../ShockwaveHitbox".show()
	$"../ShockwaveHitbox".process_mode = Node.PROCESS_MODE_INHERIT
	await get_tree().create_timer(persistence_time).timeout
	enemy_node.get_node("AnimatedSprite2D").play("casting")
	$"../ShockwaveHitbox".hide()
	$"../ShockwaveWarning".hide()
	$"../ShockwaveHitbox".process_mode = Node.PROCESS_MODE_DISABLED
	await get_tree().create_timer(cooldown_time).timeout
	exit_state()

func hit_response(source):
	$"../ShockwaveHitbox".hide()
	$"../ShockwaveHitbox".process_mode = Node.PROCESS_MODE_DISABLED
	enemy_ref.change_state("HitState")

func exit_state():
	$"../ShockwaveHitbox".hide()
	$"../ShockwaveHitbox".process_mode = Node.PROCESS_MODE_DISABLED
	if state_to_enter:
		enemy_ref.change_state(str(state_to_enter))
	else:
		enemy_ref.change_state("IdleState")

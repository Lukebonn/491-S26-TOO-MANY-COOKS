extends EnemyState

@export var Chase_Speed: int = 26


func enter_state(enemy_node):
	super(enemy_node)
	enemy_node.get_node("AnimatedSprite2D").play("chase")

func process(_delta):
	if not player_ref or not enemy_ref:
		return
	
	if player_ref.dead:
		enemy_ref.change_state(str(enemy_ref.starting_state))
		return
	
	if enemy_ref.has_method("player_in_smash_range"):
		if enemy_ref.player_in_smash_range() and enemy_ref.can_smash:
			enemy_ref.change_state("SmashState")
			return
	
	var direction = enemy_ref.get_player_vector()
	enemy_ref.velocity = Chase_Speed * direction
	
	if direction.x < 0:
		enemy_ref.get_node("AnimatedSprite2D").flip_h = false
	elif direction.x > 0:
		enemy_ref.get_node("AnimatedSprite2D").flip_h = true
	
	enemy_ref.move_and_slide()

func hit_response(_source):
	enemy_ref.change_state("HitState")

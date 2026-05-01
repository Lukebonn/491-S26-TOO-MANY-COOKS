extends EnemyState
#chase state simply follows the player
#similar to how slime_enemy does

@export var Chase_Speed : int = 26

func enter_state(enemy_node):
	super(enemy_node)
	enemy_node.get_node("AnimatedSprite2D").play("chase")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(_delta):
	if player_ref and enemy_ref:
		if not player_ref.dead:
			var direction = enemy_ref.get_player_vector()
			enemy_ref.velocity = Chase_Speed * direction
			if(direction.x < 0):
				enemy_ref.get_node("AnimatedSprite2D").flip_h = false
			if(direction.x > 0):
				enemy_ref.get_node("AnimatedSprite2D").flip_h = true
			enemy_ref.move_and_slide()
		else:
			enemy_ref.change_state(str(enemy_ref.starting_state))

func hit_response(source):
	enemy_ref.change_state("HitState")

func exit_state():
	enemy_ref.change_state("IdleState")

#hawk

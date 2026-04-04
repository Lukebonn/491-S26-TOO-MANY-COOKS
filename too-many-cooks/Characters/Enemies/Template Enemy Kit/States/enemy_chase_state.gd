extends EnemyState
#chase state simply follows the player
#similar to how slime_enemy does

@export var Chase_Speed : int = 3000

func enter_state(enemy_node):
	super(enemy_node)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(delta):
	if player_ref and enemy_ref:
		var direction = enemy_ref.get_player_vector()
		enemy_ref.velocity = Chase_Speed * direction
		enemy_ref.move_and_slide()

func hit_response(source):
	enemy_ref.change_state("HitState")

func exit_state():
	enemy_ref.change_state("IdleState")

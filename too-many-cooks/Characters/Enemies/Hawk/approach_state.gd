extends EnemyState
# An enemy state that makes the enemy approach the player,
# and then enter a different state. For use in tandem with
# another state.
# Functionally identical to the Chase State, but leaves
# the state when the enemy is close enough to the player.

@export var Chase_Speed : int = 100
@export var state_to_enter: Node
# what state should the enemy enter when they are close enough
# to the player?
@export var has_walk_sprites = false

func enter_state(enemy_node):
	super(enemy_node)
	if has_walk_sprites: enemy_node.get_node("AnimatedSprite2D").play("chaseFront")
	else: enemy_node.get_node("AnimatedSprite2D").play("chase")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(_delta):
	if player_ref and enemy_ref:
		if enemy_ref.playerNear:
			if state_to_enter:
				exit_state()
		elif not player_ref.dead:
			var direction = enemy_ref.get_player_vector()
			enemy_ref.velocity = Chase_Speed * direction
			if(direction.x < 0):
				enemy_ref.get_node("AnimatedSprite2D").flip_h = false
			if(direction.x > 0):
				enemy_ref.get_node("AnimatedSprite2D").flip_h = true
			if has_walk_sprites:
				if(direction.y < 0):
					enemy_ref.get_node("AnimatedSprite2D").play("chaseBack")
				if(direction.y > 0):
					enemy_ref.get_node("AnimatedSprite2D").play("chaseFront")
			enemy_ref.move_and_slide()
		else:
			enemy_ref.change_state(str(enemy_ref.starting_state))

func hit_response(source):
	enemy_ref.change_state("HitState")

func exit_state():
	enemy_ref.change_state(str(state_to_enter))

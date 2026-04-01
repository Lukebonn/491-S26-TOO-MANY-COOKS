extends EnemyState
#this state is called when the enemy is hit

##how far back enemy is knocked back when hit
@export var Knockback_Strength : int

##how long enemy is "stunned" after hit, set 0 for none
@export var Hit_Stun : float
func enter_state(enemy_node):
	super(enemy_node)
	if player_ref and enemy_ref:
		var direction = (enemy_ref.position -player_ref.position).normalized()
		enemy_ref.velocity = Knockback_Strength * direction
		if Hit_Stun > 0 and enemy_ref.health != 0:
			await get_tree().create_timer(Hit_Stun).timeout
		exit_state()

func process(delta):
	var tween = get_tree().create_tween()
	tween.tween_property(enemy_ref,"velocity",Vector2(0,0),Hit_Stun)
	enemy_ref.move_and_slide()
	
func exit_state():
	if enemy_ref.current_health <= 0:
		enemy_ref.change_state("DeathState")
	else:
		enemy_ref.change_state("IdleState")

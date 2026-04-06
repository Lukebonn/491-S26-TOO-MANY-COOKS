extends EnemyState
#this state is called when the enemy is hit

##how far back enemy is knocked back when hit
@export var Knockback_Strength : int

##how long enemy is "stunned" after hit, set 0 for none
@export var Hit_Stun : float

var knockback = Vector2.ZERO

func enter_state(enemy_node):
	super(enemy_node)
	if enemy_ref.current_health <= 0:
		exit_state()
	if player_ref and enemy_ref:
		var direction = (enemy_ref.position -player_ref.position).normalized()
		knockback = Knockback_Strength * direction
		var tween = get_tree().create_tween()
		tween.tween_property(self,"knockback",Vector2(0,0),Hit_Stun)
		if Hit_Stun > 0 and enemy_ref.health >= 0:
			await get_tree().create_timer(Hit_Stun).timeout
			#$Timer.start(Hit_Stun)
			#await $Timer.timeout
		exit_state()

func process(delta):
	enemy_ref.velocity = knockback
	enemy_ref.move_and_slide()
	
func exit_state():
	if enemy_ref.current_health <= 0:
		enemy_ref.change_state("DeathState")
	else:
		enemy_ref.change_state("IdleState")

extends EnemyState
#this state is called when the enemy current_health = 0 VIA the hitstate
func enter_state(enemy_node):
	super(enemy_node)
	if animation_name != "NONE":
		await $"../AnimatedSprite2D".animation_finished
	get_parent().queue_free()

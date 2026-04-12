extends EnemyState
#this state is called when the enemy current_health = 0 VIA the hitstate

##scene that enemy drops when killed
@export var Drop : PackedScene
##the low end (or amount always) that enemy drops of the above variable
@export var Drop_Amount : int
##high end of drop, set if you want random drops like 1-3 coins
@export var Drop_Amount_Max : int

func enter_state(enemy_node):
	super(enemy_node)
	if Drop_Amount > 0:
		if Drop_Amount_Max <= Drop_Amount:
			call_deferred("drop_drops", Drop_Amount)
		else:
			call_deferred("drop_drops", randi_range(Drop_Amount,Drop_Amount_Max))
	if animation_name != "NONE":
		await $"../AnimatedSprite2D".animation_finished
	get_parent().call_deferred("queue_free")
	PlayerStats.KillCount += 1
	
	
func drop_drops(amount):
	for i in amount:
		var drop = Drop.instantiate()
		drop.global_position = enemy_ref.global_position
		get_parent().add_sibling(drop)
		print("i dropped something...")

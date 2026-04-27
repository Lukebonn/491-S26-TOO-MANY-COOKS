extends EnemyState
#this state is called when the enemy current_health = 0 VIA the hitstate

@export var Drops: Array[PickupData] = []

##scene that enemy drops when killed
@export var Drop : PackedScene
##the low end (or amount always) that enemy drops of the above variable
@export var Drop_Amount : int
##high end of drop, set if you want random drops like 1-3 coins
@export var Drop_Amount_Max : int
# The sound that plays when the enemy checks out early
@export var Death_Sound: AudioStreamPlayer2D
# the enemy can die twice sometimes so for now im doing this
var has_died = false

@export var dust_effect: PackedScene

func enter_state(enemy_node):
	if !has_died:
		has_died = true
		super(enemy_node)
		if Death_Sound:
			Death_Sound.play()
		call_deferred("drop_drops")
		if get_parent().has_signal("onEnemyDeath"):
			get_parent().onEnemyDeath.emit()
		if animation_name != "NONE":
			await $"../AnimatedSprite2D".animation_finished
		
		# Spawn dust particles at enemy position
		if dust_effect:
			print("SPAWNING DUST at: ", enemy_ref.global_position)
			var dust = dust_effect.instantiate()
			dust.global_position = enemy_ref.global_position
			get_parent().add_sibling(dust)
			print("DUST SPAWNED: ", dust)
		else:
			print("DUST EFFECT IS NULL")
		
		get_parent().call_deferred("queue_free")
		PlayerStats.KillCount += 1
		if EnemyStats.enemies_in_room > 0:
			EnemyStats.enemies_in_room -= 1
		if Global.Has_Warrior_Quest_1:
			PlayerStats.Quest1EnemiesKOs += 1

func drop_drops():
	#for i in amount:
		#var drop = Drop.instantiate()
		#drop.global_position = enemy_ref.global_position
		#get_parent().add_sibling(drop)
	for drop in Drops:
		var c = randf_range(0.0, 1.0)
		if drop.DropChance >= c:
			var i = int(randf_range(drop.DropCountRange.x, drop.DropCountRange.y))
			for d in i:
				var inst = drop.SceneToSpawn.instantiate()
				inst.global_position = enemy_ref.global_position
				get_parent().add_sibling(inst)

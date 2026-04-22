extends EnemyState
#unimplemented so far

var xDifference
var yDifference
@export var speed: float
# Works inversely compared to what you might be familiar with
# Lower speed values increase the speed at which the enemy
# dashes towards you

var dashing = false
signal dashComplete

func enter_state(enemy_node):
	super(enemy_node)

func process(delta: float) -> void:
	if player_ref and enemy_ref and not dashing:
		yDifference = player_ref.position.y - enemy_ref.position.y
		#print(yDifference)
		if abs(yDifference) < 0.75:
			# if the difference in y-axis positions is very small,
			# then the enemy and the player are nearly on the same
			# y-level, so...
			await get_tree().create_timer(0.1).timeout
			dashing = true # ...Move on to next step
			xDifference = player_ref.position.x - enemy_ref.position.x
			if xDifference < 0: # negative -> player to left of enemy
				dash("Right")
				await dashComplete
				dashing = false
			elif xDifference > 0: # positive -> player to right of enemy
				#enemy_ref.position += Vector2(1, 0)
				dash("Left")
				await dashComplete
				dashing = false
		elif (yDifference) < 0:
			#print("Player is above me")
			# if the difference is negative,
			# then the player is above the enemy, so move up
			if yDifference > -1:
				enemy_ref.position += Vector2(0, -0.3)
			else:
				enemy_ref.position += Vector2(0, -2)
			#enemy_ref.position += Vector2(0, -2)
		elif (yDifference) > 0:
			#print("Player is below me")
			# if the difference is positive, 
			# then the player is below the enemy, so move down
			if yDifference < 1:
				enemy_ref.position += Vector2(0, 0.3)
			else:
				enemy_ref.position += Vector2(0, 2)
			#enemy_ref.position += Vector2(0, 2)

		
	# The Plan:
	# 1. Enemy will attempt to line up horizontally with the player.
	# Check if the player is above or below them, and move
	# upwards/downwards accordingly.
	# 2. Once in-line with the player, commence with a dash toward
	# the player (after checking which side of the player they're on)
	# 3. The enemy will come to a stop after they have passed the player
	# Afterwards, maybe they will continue in the ChaseState.
	# Either that, or implement the JunctionState where the enemy
	# chooses to either continue with a chase or a dash.

func hit_response(source):
	pass #enemy_ref.change_state("HitState")

func dash(direction: String):
	var tween = self.create_tween()
	xDifference = player_ref.position.x - enemy_ref.position.x
	match direction:
		"Right":
			tween.tween_property(
				enemy_ref, 
				"position", 
				Vector2(enemy_ref.position.x - abs(xDifference) - 35, enemy_ref.position.y), 
				speed).set_trans(Tween.TRANS_EXPO)
		"Left":
			tween.tween_property(
				enemy_ref, 
				"position", 
				Vector2(enemy_ref.position.x + abs(xDifference) + 35, enemy_ref.position.y), 
				speed).set_trans(Tween.TRANS_EXPO)
	await get_tree().create_timer(1.0).timeout
	dashComplete.emit()

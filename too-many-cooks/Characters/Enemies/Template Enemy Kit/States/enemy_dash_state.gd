extends EnemyState
#unimplemented so far

enum dashSteps {
	align,
	wait,
	dash,
	stop
}

var dashStep
var xDifference
var yDifference

func enter_state(enemy_node):
	super(enemy_node)
	dashStep = dashSteps.align

func _process(delta: float) -> void:
	if player_ref and enemy_ref:
		match dashStep: #woawie a match statement
			dashSteps.align:
				yDifference = player_ref.position.y - enemy_ref.position.y
				print(yDifference)
				if abs(yDifference) < 0.5:
					# if the difference in y-axis positions is very small,
					# then the enemy and the player are nearly on the same
					# y-level, so...
					dashStep = dashSteps.wait # ...Move on to next step
				elif (yDifference) < 0:
					#print("Player is above me")
					# if the difference is negative,
					# then the player is above the enemy, so move up
					enemy_ref.position += Vector2(0,-0.75)
				elif (yDifference) > 0:
					#print("Player is below me")
					# if the difference is positive, 
					# then the player is below the enemy, so move down
					enemy_ref.position += Vector2(0,0.75)
			dashSteps.wait:
				await get_tree().create_timer(0.1).timeout
				xDifference = player_ref.position.x - enemy_ref.position.x
				dashStep = dashSteps.dash
				# waits a moment, so the player has time to move,
				# and then gets the distance the enemy is from the player
				# when the dash should begin, and then move on to dashing
			dashSteps.dash:
				## THIS PART IS VERY ROUGH AROUND THE EDGES!
				## I intend on polishing this up much more later.
				var xDistance = player_ref.position.x - enemy_ref.position.x
				#print(str(xDistance) + " " + str(xDifference))
				if xDifference < 0: # negative -> player to left of enemy
					enemy_ref.position += Vector2(-1, 0)
					if xDistance >= 30:
						dashStep = dashSteps.stop
				elif xDifference > 0: # positive -> player to right of enemy
					enemy_ref.position += Vector2(1, 0)
					if xDistance <= -30:
						dashStep = dashSteps.stop
			dashSteps.stop:
				# THIS STUFF TO BE REPLACED PROBABLY.
				await get_tree().create_timer(0.5).timeout
				dashStep = dashSteps.align

		
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
	pass 
	## Dawson changed this to pass so the whole dash procedure
	## is not interrupted when the player hits the enemy during it.
	#enemy_ref.change_state("HitState")
	# because of this, hitting the enemy while they're dashing will
	# break their dash, and hitting them will probably be very easy,
	# so im not sure if this should be a feature.

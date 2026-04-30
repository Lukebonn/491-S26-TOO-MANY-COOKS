extends EnemyState
#unimplemented so far

var xDifference
var yDifference
var extraX
var stuckOnWall
@export var speed: float
# Works inversely compared to what you might be familiar with
# Lower speed values increase the speed at which the enemy
# dashes towards you
@export var state_to_enter: Node

var dashing = false
signal dashComplete

func enter_state(enemy_node):
	super(enemy_node)

func process(delta: float) -> void:
	if player_ref and enemy_ref and not dashing:
		extraX = 0
		xDifference = player_ref.position.x - enemy_ref.position.x
		yDifference = player_ref.position.y - enemy_ref.position.y
		#print(yDifference)
		if abs(yDifference) < 0.75:
			# if the difference in y-axis positions is very small,
			# then the enemy and the player are nearly on the same
			# y-level, so...
			enemy_ref.velocity = Vector2(0, 0)
			await get_tree().create_timer(0.1).timeout
			dashing = true # ...Move on to next step
			if xDifference < 0: # negative -> player to left of enemy
				$"../DashLine".target_position = Vector2(xDifference - 35, 0)
				dash("Right")
				await dashComplete
				dashing = false
				exit_state()
			elif xDifference > 0: # positive -> player to right of enemy
				#enemy_ref.position += Vector2(1, 0)
				$"../DashLine".target_position = Vector2(xDifference + 35, 0)
				dash("Left")
				await dashComplete
				dashing = false
				exit_state()
		elif (yDifference) < 0:
			#print("Player is above me")
			# if the difference is negative,
			# then the player is above the enemy, so move up
			if not stuckOnWall: $"../DashLine".target_position = Vector2(0, -7.5)
			if $"../DashLine".is_colliding():
				stuckOnWall = true
				if xDifference < 0: # negative -> player to left of enemy
					extraX = -100
					$"../DashLine".target_position = Vector2(10, -7.5)
				elif xDifference > 0: # positive -> player to right of enemy
					extraX = 100
					$"../DashLine".target_position = Vector2(-10, -7.5)
			else:
				stuckOnWall = false
			if yDifference > -1:
				enemy_ref.velocity = Vector2(extraX, -3)
			else:
				enemy_ref.velocity = Vector2(extraX, -100)
			#enemy_ref.position += Vector2(0, -2)
		elif (yDifference) > 0:
			#print("Player is below me")
			# if the difference is positive, 
			# then the player is below the enemy, so move down
			if not stuckOnWall: $"../DashLine".target_position = Vector2(0, 7.5)
			if $"../DashLine".is_colliding():
				stuckOnWall = true
				if xDifference < 0: # negative -> player to left of enemy
					extraX = -100
					$"../DashLine".target_position = Vector2(10, 7.5)
				elif xDifference > 0: # positive -> player to right of enemy
					extraX = 100
					$"../DashLine".target_position = Vector2(-10, 7.5)
			else:
				stuckOnWall = false
			if yDifference < 1:
				enemy_ref.velocity = Vector2(extraX, 3)
			else:
				enemy_ref.velocity = Vector2(extraX, 100)
			#enemy_ref.position += Vector2(0, 2)
	enemy_ref.move_and_slide()

func hit_response(source):
	pass #enemy_ref.change_state("HitState")

func exit_state():
	$"../DashLine".target_position = Vector2(0, 0)
	if state_to_enter:
		enemy_ref.change_state(str(state_to_enter))
	else:
		enemy_ref.change_state("IdleState")

func dash(direction: String):
	var tween = self.create_tween()
	$"../DashLine".target_position = Vector2(0, 0)
	var additional_distance = 35
	xDifference = player_ref.position.x - enemy_ref.position.x
	#print(xDifference)
	match direction:
		"Right":
			$"../DashLine".target_position = Vector2(xDifference - 35, 0)
			if $"../DashLine".is_colliding(): additional_distance = -10
			tween.tween_property(
				enemy_ref, 
				"position", 
				Vector2(enemy_ref.position.x - abs(xDifference) - additional_distance, enemy_ref.position.y), 
				speed).set_trans(Tween.TRANS_EXPO)
			enemy_ref.get_node("AnimatedSprite2D").flip_h = false
		"Left":
			$"../DashLine".target_position = Vector2(xDifference + 35, 0)
			if $"../DashLine".is_colliding(): additional_distance = -10
			tween.tween_property(
				enemy_ref, 
				"position", 
				Vector2(enemy_ref.position.x + abs(xDifference) + additional_distance, enemy_ref.position.y), 
				speed).set_trans(Tween.TRANS_EXPO)
			enemy_ref.get_node("AnimatedSprite2D").flip_h = true
	await get_tree().create_timer(1.0).timeout
	dashComplete.emit()

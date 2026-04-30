extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print(get_parent().player_ref.position)
	position = get_parent().enemy_ref.position
	look_at(get_parent().player_ref.position)
	match name:
		"1":
			lerp_move_to_target(Vector2(get_parent().player_ref.position.x, get_parent().player_ref.position.y - 56))
		"2":
			lerp_move_to_target(get_parent().player_ref.position)
		"3":
			lerp_move_to_target(Vector2(get_parent().player_ref.position.x, get_parent().player_ref.position.y + 56))
	

func lerp_move_to_target(target: Vector2):
	# our interested variable is position (built-in)
	var start_pos = position
	# ending position is target (parameter the function was given)
	var total_time = 2.0
	var time_elapsed = 0.0
	var lerp_value
	
	while time_elapsed < total_time:
		lerp_value = time_elapsed / total_time
		# lerp value = ratio between time elapsed and total time
		position = start_pos.lerp(target, lerp_value)
		await get_tree().process_frame
		time_elapsed += get_process_delta_time()
	
	position = target

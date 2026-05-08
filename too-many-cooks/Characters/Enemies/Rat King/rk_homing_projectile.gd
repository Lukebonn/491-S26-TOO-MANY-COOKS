extends CharacterBody2D

var enemy_ref
var player_ref
var direction
var follow_path = false
var player_in_range = false
@export var state_ref: Node
@export var damage: int
@export var projectile_speed: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	direction = (player_ref.global_position - global_position).normalized()
	velocity = projectile_speed * direction

func _physics_process(delta: float) -> void:
	if player_in_range: 
		lerp_to_player((player_ref.global_position - global_position).normalized())
		look_at(Vector2(player_ref.position.x, player_ref.position.y))
	velocity = projectile_speed * direction
	move_and_slide()


func _on_near_zone_area_entered(area: Area2D) -> void:
	player_in_range = true
	print(player_in_range)


func _on_near_zone_area_exited(area: Area2D) -> void:
	player_in_range = false
	print(player_in_range)

func lerp_to_player(target: Vector2):
	var start_dir = direction
	var total_time = 0.1
	var time_elapsed = 0.0
	var lerp_value
	
	while time_elapsed < total_time:
		lerp_value = time_elapsed / total_time
		# lerp value = ratio between time elapsed and total time
		direction = start_dir.lerp(target, lerp_value)
		await get_tree().process_frame
		time_elapsed += get_process_delta_time()
	
	#direction = (player_ref.global_position - global_position).normalized()

func _on_persistence_time_timeout() -> void:
	queue_free()

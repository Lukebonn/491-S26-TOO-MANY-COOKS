extends Area2D

var enemy_ref_pos
var player_ref_pos
var follow_path = false
@export var state_ref: Node
@export var damage: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if state_ref:
		state_ref.connect("fire_projectiles", _on_fire_projectiles)

func _process(delta: float) -> void:
	if get_parent().progress_ratio >= 1: 
		get_parent().progress_ratio = 0
		queue_free()
	if follow_path: get_parent().progress_ratio += 0.5 * delta
	

func _on_fire_projectiles() -> void:
	follow_path = true

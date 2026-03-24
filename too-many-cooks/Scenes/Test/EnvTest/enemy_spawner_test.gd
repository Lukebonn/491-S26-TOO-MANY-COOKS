extends Node2D

#in the future these variables will be global
var current_wave: int
var moving_to_next_wave: bool

@onready var wave_transition_animation = $WaveTransitionAnimation

#@onready var slime_enemy: CharacterBody2D = $SlimeEnemy
#const COMBAT_TEST = preload("uid://cnv3j3ikeoqgb")
@export var slime_scene: PackedScene
@export var skeleton_scene: PackedScene

var starting_nodes: int
var current_nodes: int
var wave_spawn_ended

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_wave = 0
	# TODO: here is where you would update the global variable current wave to this script's current wave
	starting_nodes = get_child_count()
	current_nodes = get_child_count()
	position_to_next_wave()
	
func position_to_next_wave():
	if current_nodes == starting_nodes:
		#wave_transition_animation.play("between_wave")
		current_wave += 1
		# TODO: update current wave GLOBAL variable
		await get_tree().create_timer(0.5).timeout
		#prepare spawn
		print(current_wave)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

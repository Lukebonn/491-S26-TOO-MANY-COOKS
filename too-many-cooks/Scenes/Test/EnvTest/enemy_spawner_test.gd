extends Node2D

var current_wave: int

#@onready var slime_enemy: CharacterBody2D = $SlimeEnemy
#const COMBAT_TEST = preload("uid://cnv3j3ikeoqgb")
@export var slime_scene: PackedScene
@export var skeleton_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

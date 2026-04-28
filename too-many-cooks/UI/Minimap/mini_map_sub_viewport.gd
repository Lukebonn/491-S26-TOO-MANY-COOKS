'''extends SubViewport

@onready var player: CharacterBody2D = $"../../../../Player"
@onready var camera_2d := $Camera2D

func _ready() -> void:
	print("FOG PLAYER: ", player)
	world_2d = get_tree().root.world_2d
	canvas_cull_mask = canvas_cull_mask & ~(1 << 1)

func _physics_process(delta: float) -> void:
	if player:
		$Camera2D.position = player.position
		
	
	
'''	
extends SubViewport

func _ready() -> void:
	world_2d = get_tree().root.world_2d
	canvas_cull_mask = canvas_cull_mask & ~(1 << 1)

func _physics_process(delta: float) -> void:
	pass #'''

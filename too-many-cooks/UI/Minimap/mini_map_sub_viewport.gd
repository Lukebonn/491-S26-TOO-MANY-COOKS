#Everything is commented out for now!

extends SubViewport

@onready var player: CharacterBody2D = $"../../../Player" #not sure if we have a player alredy

@onready var camera_2d: = $Camera2D

#fill in the sprite with what the player should be on the mini map
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	world_2d = get_tree().root.world_2d
	


#Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta:float) -> void:
	#sets camera pos to player pos
	$Camera2D.position = player.position

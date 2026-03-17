extends Node2D

@export var Enemies : Array[PackedScene]
#The enemies to spawn.
@export var SpawnRadius : float = 32.0
#The radius at which to spawn enemies at.
var rotInc : float
#Incriment of rotation, used in circle spawn logic.
var canSpawn = true
#Whether or not we can actually spawn enemies.

func _ready() -> void:
	#Calculate rotation incriment for later.
	rotInc = 360 * 1/float(Enemies.size())

func try_spawn_enemies() -> void:
	if canSpawn:
		#Disable future spawning, spawn enemies next physics frame.
		canSpawn = false
		call_deferred("spawn_enemies")
		#Use call deferred, have to wait until physics frame is done.

func spawn_enemies() -> void:
	#Iterate through Enemies and spawn each scene.
	for i in Enemies.size():
		var instance = Enemies[i].instantiate()
		add_child(instance)
		instance.position = calc_spawn_pos(i)

func calc_spawn_pos(i: int):
	#Return rotated Vec2 based on incriment * index.
	return Vector2(SpawnRadius,0).rotated(deg_to_rad(rotInc * i))

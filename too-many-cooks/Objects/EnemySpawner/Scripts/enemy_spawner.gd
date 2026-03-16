extends Node2D

@export var Enemies : Array[PackedScene]
#The enemies to spawn.
@export var SpawnRadius : float = 32.0
#The radius at which to spawn enemies at.
var spawnRoot : Marker2D
var spawnPoint : Marker2D
#Refs to spawn comps, used in circle spawn logic.
var rotInc : float
#Incriment of rotation, used in circle spawn logic.
var canSpawn = true
#Whether or not we can actually spawn enemies.

func _ready() -> void:
	#Initialize refs, calculate rotation incriment for later.
	spawnRoot = $SpawnRoot
	spawnPoint = $SpawnRoot/SpawnPoint
	spawnPoint.position = Vector2(SpawnRadius, 0)
	rotInc = 360 * 1/float(len(Enemies))

func try_spawn_enemies() -> void:
	if canSpawn:
		#Disable future spawning, spawn enemies next physics frame.
		canSpawn = false
		call_deferred("spawn_enemies")

func spawn_enemies() -> void:
	#Iterate through Enemies and spawn each scene.
		for i in Enemies.size():
			var instance = Enemies[i].instantiate()
			add_child(instance)
			instance.position = calc_spawn_pos(i)

func calc_spawn_pos(i: int):
	#Rotate SpawnRoot to the given interation incriment.
	spawnRoot.rotation = rotInc * i
	return spawnPoint.position
	#Return Point's pos (Point rotates w/ Root, gives spawn pos).

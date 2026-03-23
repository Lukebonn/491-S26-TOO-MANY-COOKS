extends Node2D
signal on_spawn
signal on_all_dead

##The enemies to spawn from this Spawner.
@export var Enemies : Array[PackedScene]
##The radius at which enemies will be spawned at.
@export var SpawnRadius : float = 32.0
##The radius of the base collision shape in this Spawner.
@export var CollisionRadius : float = 64.0

var rotInc : float
#Incriment of rotation, used in circle spawn logic.
var canSpawn = true
#Whether or not we can actually spawn enemies.
var num_enemies : int
#The number of enemies spawned, used to track how many are alive.

func _ready() -> void:
	#Calculate rotation incriment for later.
	rotInc = 360 * 1/float(Enemies.size())
	#Save number of enemies for later.
	num_enemies = Enemies.size()
	$BaseColObj/BaseCol.shape.radius = CollisionRadius
	$Sprite.hide()

func try_spawn_enemies() -> void:
	if canSpawn:
		#Disable future spawning, spawn enemies next physics frame.
		canSpawn = false
		#Use call deferred, have to wait until physics frame is done.
		call_deferred("spawn_enemies")
		on_spawn.emit()

func spawn_enemies() -> void:
	#Iterate through Enemies and spawn each scene.
	for i in Enemies.size():
		var instance = Enemies[i].instantiate()
		add_child(instance)
		instance.position = calc_spawn_pos(i)
		instance.tree_exited.connect(on_enemy_dead)

func calc_spawn_pos(i: int):
	#Return rotated Vec2 based on incriment * index.
	return Vector2(SpawnRadius,0).rotated(deg_to_rad(rotInc * i))

func on_enemy_dead() -> void:
	num_enemies -= 1
	if num_enemies <= 0:
		on_all_dead.emit()

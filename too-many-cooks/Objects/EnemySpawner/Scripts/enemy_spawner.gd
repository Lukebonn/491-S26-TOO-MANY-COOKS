extends Node2D
signal on_spawn
signal on_all_dead
enum LocType {FixedRadius, AlongPath, RadiusRange}

##Whether or not enemies will spawn randomly in this spawner's given location type.
##This must be true for the RadiusRange location type to work.
@export var RandomLocation : bool = false
##The enemies to spawn from this Spawner.
@export var Enemies : Array[PackedScene]
##The radius of the base collision shape in this Spawner.
##This Spawner will begin spawning from Enemies when the player enters this radius.
@export var CollisionRadius : float = 64.0

@export_group("Location Handling")
##The type of location handling to use when spawning from Enemies.
##FixedRadius means enemies will spawn a fixed distance away from the spawner.
##AlongPath means enemies will spawn along a Path2D (MUST be assigned!)
##RadiusRange means enemies will spawn within a min-max radius range.
##RadiusRange requires RandomLocation to be true!
@export var LocationType : LocType
##The radius at which enemies will be spawned at, if LocationType is FixedRadius.
@export var SpawnRadius : float = 32.0

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

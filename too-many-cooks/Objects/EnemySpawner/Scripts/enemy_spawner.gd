extends Node2D
signal on_spawn
signal on_all_dead
enum LocType {
	FixedRadius, ##Enemies spawn a fixed distance away from the spawner.
	AlongPath, ##Enemies spawn along the assigned SpawnPath.
	RadiusRange, ##Enemies spawn within a min-max radius range. Works best with RandomLocation!
	SetPoints ##Each Enemy spawns as the SpawnPoint of the same index. IGNORES RandomLocation!
	}
enum SpawnType {
	Burst, ##Burst means enemies will spawn all at once.
	Constant ##Constant means enemies will continuously spawn with some delay.
	}

##Whether or not enemies will spawn randomly in the given location type. IGNORED by SetPoints!
@export var RandomLocation : bool = false
##The enemies to spawn from this Spawner.
@export var Enemies : Array[PackedScene]
##The radius of the base collision shape in this Spawner.
##This Spawner will begin spawning from Enemies when the player enters this radius.
@export var CollisionRadius : float = 64.0

@export_group("Location Handling")
##The type of location handling to use when spawning from Enemies.
@export var LocationType : LocType
##The radius at which enemies will be spawned at, if LocationType is FixedRadius.
@export var SpawnRadius : float = 32.0
##The minimum range at which enemies will be spawned at, if LocationType is RadiusRange.
@export var RadiusRangeMin : float = 32.0
##The maximum range at which enemies will be spawned at, if LocationType is RadiusRange.
@export var RadiusRangeMax : float = 64.0
##The Path2D enemies will spawn along, if LocationType is AlongPath.
@export var SpawnPath : Path2D
##The points to spawn each Enemy at, if LocationType is SetPoints. Assignments should be children of this Spawner!
@export var SpawnPoints : Array[Node2D]

@export_group("Spawn Handling")
##The spawn method to use while spawning enemies.
@export var SpawnMethod : SpawnType
##The time (in seconds) to wait before spawning an additional enemy.
##Leave as 0.0 for a single "wave" of enemies spawned.
@export var SpawnInterval : float = 0.0
##The maximum number of enemies that can be handled by this Spawner at once.
@export var SpawnLimit : int = 64
##The number of enemies that must be defeated for the "on_all_dead" signal to be emitted, if SpawnMethod is Constant.
@export var DefeatCount : int = 8

#Whether or not this Spawner is active (and thus should emit signals).
var active : bool = true
#Incriment of rotation, used in circle spawn logic.
var rotInc : float
#Whether or not we can actually spawn enemies.
var canSpawn = true
#Length of Enemies array.
var array_length : int
#Number of enemies currently spawned.
var enemy_count : int
#Number of enemies that have been defeated.
var enemies_defeated : int
#Reference to Interval timer.
var interval : Timer
#Length of SpawnPath.
var path_length : float = 0.0
#Current step in Enemies, for Constant spawn method.
var cur_step : int = 0

func _ready() -> void:
	#Calculate rotation incriment for later.
	rotInc = 360 * 1/float(Enemies.size())
	array_length = Enemies.size()
	$BaseColObj/BaseCol.shape.radius = CollisionRadius
	interval = $Interval
	$Sprite.hide()
	if SpawnPath:
		path_length = SpawnPath.curve.get_baked_length()

func try_spawn_enemies() -> void:
	if canSpawn && not enemy_count >= SpawnLimit:
		#Disable future spawning, spawn enemies next physics frame.
		canSpawn = false
		#Use call deferred, have to wait until physics frame is done.
		call_deferred("spawn_enemies")
		on_spawn.emit()
		#Start timer interval if >0.
		if SpawnInterval > 0:
			interval.start()
func _on_interval_timeout() -> void:
	canSpawn = true
	try_spawn_enemies()

func spawn_enemies() -> void:
	if SpawnMethod == SpawnType.Burst:
		#Iterate and spawn all enemies at once.
		for i in Enemies.size():
			var instance = Enemies[i].instantiate()
			get_parent().add_child(instance)
			instance.position = calc_spawn_pos(i)
			instance.tree_exited.connect(on_enemy_dead)
			enemy_count += 1
	if SpawnMethod == SpawnType.Constant:
		#Spawn each enemy as we step through Enemies.
		if cur_step >= array_length:
			cur_step = 0
		var instance = Enemies[cur_step].instantiate()
		get_parent().add_child(instance)
		instance.position = calc_spawn_pos(cur_step)
		instance.tree_exited.connect(on_enemy_dead)
		enemy_count += 1
		cur_step += 1

func calc_spawn_pos(i: int):
	if LocationType == LocType.FixedRadius:
		if RandomLocation:
			#Return rotated Vec2 based on random float in range.
			return position + Vector2(SpawnRadius,0).rotated(deg_to_rad(randf_range(0, 360)))
		else:
			#Return rotated Vec2 based on incriment * index.
			return position + Vector2(SpawnRadius,0).rotated(deg_to_rad(rotInc * i))
	if LocationType == LocType.AlongPath:
		#Check that SpawnPath is actually valid (assigned).
		if SpawnPath:
			if RandomLocation:
				#Return random point along path between 0 and path length.
				return position + Vector2(SpawnPath.curve.sample_baked(randf_range(0, path_length)))
			else:
				#Return even point along path using incriment * index.
				var path_inc = path_length * (1.0/float(array_length))
				return position + Vector2(SpawnPath.curve.sample_baked(path_inc * i))
		else:
			#Invalid SpawnPath, push error and return world origin as fallback.
			push_error(self.name + " uses AlongPath spawning, but no Path2D is assigned!")
			return position + Vector2(0, 0)
	if LocationType == LocType.RadiusRange:
		if RandomLocation:
			#Return rotated Vec2 in min-max range based on random float in range.
			return position + Vector2(randf_range(RadiusRangeMin, RadiusRangeMax),0).rotated(deg_to_rad(randf_range(0, 360)))
		else:
			#Return rotated Vec2 in min-max range based on incriment * index.
			return position + Vector2(SpawnRadius,0).rotated(deg_to_rad(rotInc * i))
	if LocationType == LocType.SetPoints:
		return position + Vector2(SpawnPoints[i].position)

func on_enemy_dead() -> void:
	enemies_defeated += 1
	enemy_count -= 1
	enemy_count = clampi(enemy_count, 0, SpawnLimit)
	if SpawnInterval == 0:
		#Emit all dead if count is 0.
		if enemy_count <= 0:
			on_all_dead.emit()
			active = false
			return
	else:
		#Emit all dead if defeat count meets requirement.
		if enemies_defeated >= DefeatCount && active:
			on_all_dead.emit()
			interval.stop()
			active = false
			return

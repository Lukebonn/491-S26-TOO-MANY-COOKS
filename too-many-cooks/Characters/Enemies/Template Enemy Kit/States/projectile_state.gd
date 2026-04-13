extends EnemyState

##The projectile the state uses. Meant to work with everything intended for enemies
@export var Projectile : PackedScene
##The speed of the spawned projectile. Acts as more of a multiplier for Arrow since that thing locomotes in a way I don't want to debug rn
@export var Projectile_Speed : int 
##Time between shots
@export var Idle_Time : float
##Do you want the enemy to move back a bit when firing? Meant for smarter enemies. [EXPERIMENTAL!!!]
@export var Flee_While_Firing : bool
##How far should the enemy move back when firing?
@export var Flee_Speed : float
##whether or not player's location is needed for the projectile (in the case of projectiles that arc, the end of the arc needs to be known, so for the hob lobber specfically
@export var Player_Location_Needed_For_Projectile : bool

var fired = true

func enter_state(enemy_node):
	print("entered projectile state")
	fired = true
	super(enemy_node)
	await get_tree().create_timer(Idle_Time/2).timeout
	fired = false

func process(_delta):
	if fired == false:
		fire()
		if Flee_While_Firing:
			flee()
	
func fire():
	fired = true
	#make a raycast to get a vector or position for projectiles to go to
	var raycast = RayCast2D.new()
	raycast.global_position = enemy_ref.global_position
	raycast.target_position = enemy_ref.get_player_vector() * Projectile_Speed
	add_child(raycast)
	#make a new projectile, set its stuff
	var new_proj = Projectile.instantiate()
	new_proj.position = enemy_ref.position
	new_proj.direction = raycast.target_position
	#The point of this is to give the location of the "player" to the projectile on instantiation
	if Player_Location_Needed_For_Projectile and player_ref != null:
		new_proj.playerLocation = player_ref.global_position
	#adds as sibling so projectile doesn't vanish if enemy is KO'd
	add_sibling(new_proj)
	print("fired new_proj")
	await get_tree().create_timer(Idle_Time).timeout
	fired = false
	exit_state()
func flee():
	enemy_ref.velocity = enemy_ref.get_player_vector() * -1 * Flee_Speed
	while enemy_ref.velocity.length() > 1:
		var tween = get_tree().create_tween()
		tween.tween_property(enemy_ref,"velocity",Vector2(0,0),.2)
		enemy_ref.position += enemy_ref.velocity
		enemy_ref.move_and_slide()
		await get_tree().process_frame
	await get_tree().create_timer(Idle_Time).timeout
		
func exit_state():
	enemy_ref.velocity = Vector2(0,0)
	enemy_ref.call_deferred("change_state", "IdleState")

func hit_response(source):
	enemy_ref.change_state("HitState")

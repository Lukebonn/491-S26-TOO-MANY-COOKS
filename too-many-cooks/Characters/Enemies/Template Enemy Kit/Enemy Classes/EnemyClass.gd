class_name Enemy extends CharacterBody2D

#if you want to make a new enemy, duplicate this scene
#then give it a new script, so that it's no longer gray
#then start changing variables and making scenes!

#the code in this script will run every frame
#the state code will only run if that specific state is the current_state

var player_in_sight : bool
var player_ref : CharacterBody2D
var current_state : EnemyState

##starting health of enemy
@export var health : int 
var current_health = health
##damage normal attacks will do 
@export var damage : int 
##The state that should be entered when player comes into sight
@export var sight_state : EnemyState
##The state that the enemy should start on
@export var starting_state : EnemyState

func _ready():
	current_state = starting_state
	current_state.enter_state(self)
	current_health = health
	
func change_state(new_state : String):
	if(!current_state): #just in case current_state is null for some reason
		current_state.exit_state()
	print("Switching to enemy state: " + new_state)
	current_state = get_node(new_state)
	current_state.enter_state(self)

func _physics_process(delta: float) -> void:
	current_state.process(delta)


#collision signals
func _on_sight_body_entered(body):
	if body.name == "Player":
		player_ref = body
		player_in_sight = true
		if sight_state:
			current_state = sight_state
			current_state.enter_state(self)

func _on_sight_body_exited(body):
	if body.name == "Player":
		player_in_sight = false
	if sight_state:
		sight_state.exit_state()

func _on_hurtbox_area_entered(area):
	current_state.hit_response(area)
	take_damage(area.get_parent().damage)

func _on_hurtbox_body_entered(body):
	current_state.hit_response(body)
	take_damage(body.get_parent().damage)

func take_damage(inc_damage: int):
	current_health = current_health - inc_damage
	var damage_number = preload("res://Characters/Enemies/Scenes/DamageNumber.tscn").instantiate()
	damage_number.Number = inc_damage
	add_child(damage_number)
	current_state.hit_response(1)
	
	
func _on_hitbox_area_entered(_area):
	pass # Replace with function body.


func _on_hitbox_body_entered(_body):
	pass # Replace with function body.

class_name HobLobberEnemy
extends CharacterBody2D

var player_in_sight : bool = false
var player_ref : Area2D = null
var current_state : EnemyState = null

@export var health : int = 10
var current_health : int

@export var damage : int = 2
@export var sight_state : EnemyState
@export var starting_state : EnemyState

func _ready():
	current_health = health
	current_state = starting_state
	self.modulate=Color(0.0, 0.498, 0.0, 1.0)
	if current_state:
		current_state.enter_state(self)
	else:
		push_warning("No starting_state assigned for enemy: " + name)

func change_state(state_name: String):
	
	if current_state:
		current_state.exit_state()
	
	var new_state = get_node(state_name)
	if new_state == null:
		push_error("Enemy tried to switch to missing state: " + state_name)
		return
	
	current_state = new_state
	current_state.enter_state(self)

func _physics_process(delta):
	if current_state:
		current_state.process(delta)

func get_player_vector():
	if player_ref == null:
		return Vector2.ZERO
	return (player_ref.global_position - global_position).normalized()

func take_damage(amount: int):
	current_health -= amount
	current_state.hit_response(amount)


# SIGNALS -----------------------------------------------------------------

#func _on_sight_body_entered(body):
	#if body.name == "Player":
		#player_ref = body
		#player_in_sight = true
		#
		#if sight_state:
			#change_state(sight_state.name)
#
#func _on_sight_body_exited(body):
	#if body.name == "Player":
		#player_in_sight = false
		#change_state("IdleState")

##these have been temporarily disabled for testing
#func _on_hurtbox_area_entered(area):
	#take_damage(area.get_parent().damage)
#
	#if current_state != $HitState:
		#change_state("HitState")
#
#func _on_hurtbox_body_entered(body):
	#if body.has_method("take_damage"):
		#body.take_damage(damage)
	#
	#if current_state != $HitState:
		#change_state("HitState")


func _on_sight_area_entered(area: Area2D) -> void:
	print(area.name)
	if area.name == "Player":
		player_ref = area
		player_in_sight = true
		
		if sight_state:
			change_state("ProjectileState")


func _on_sight_area_exited(area: Area2D) -> void:
	print(area.name)
	if area.name == "Player":
		player_in_sight = false
		change_state("IdleState")

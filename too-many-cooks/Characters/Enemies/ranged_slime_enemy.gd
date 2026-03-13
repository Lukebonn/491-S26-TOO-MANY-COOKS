#extends CharacterBody2D
#
##for temp health
#@onready var temp_health_bar: ProgressBar = $"Temp Health Bar"
#
#const SPEED = 100.0
#const KNOCKBACK_FORCE: int = 20
#var player_chase=false
#var player = null
#
#var is_alive: bool = true
#var health: int = 100
#var target = null
#
##ranged attack variables
#var bow_cooldown
#var arrow = preload("res://Characters/Enemies/arrow.tscn")
#
#signal allEnemiesDead()
## Dawson - this signal serves as a marker for when all the enemies
## on the floor have been defeated. As of now, its sole purpose is
## to spawn the exit staircase.
#
#@export var damage = 10
#@onready var take_damage_sound: AudioStreamPlayer2D = $TakeDamage
#
#func _ready():
	#temp_health_bar.value = health #attach health bar to enemy
#
#func _physics_process(delta: float) -> void:
	##if is_alive and target:
		##_attack(delta) 
	#
	## *note* ideally would put this in take damage but 
	## this health bar is for playtest.
	#temp_health_bar.value = health #update enemy health bar
	#
	#if player_chase:
		##getting player's location
		#var player_pos = player.position-position
		#position += (player.position-position)/SPEED
		#$Marker2D.look_at(player_pos)
		#if bow_cooldown and target != null:
			#bow_cooldown = false
			#var arrow_instance = arrow.instantiate()
			#arrow_instance.rotatation = $Marker2D.rotation
			#arrow_instance.global_position = $Marker2D.global_position
			#add_child(arrow_instance)
			#
			#await get_tree().create_timer(0.4).timeout
			#bow_cooldown = true
	#
#
##func _attack(delta: float) -> void:
	##var direction = (target.position - position).normalized()
	##position += direction * SPEED * delta
	##animated_sprite_2d.play("attack_side")
	#
##function that can be called from the player to deal damage to the slime
#func take_damage(self_damage: int, attacker_position: Vector2) -> void: 
	#health -= self_damage
	#if health <= 0:
		#_die()
	#else:
		#print(health)
		#take_damage_sound.play() #pending audio to the take damage
		#
		##Knockback
		#var knockback_direction = (position - attacker_position).normalized()
		#var target_position = position + knockback_direction * KNOCKBACK_FORCE
		#
		#var tween = create_tween()
		#tween.set_ease(Tween.EASE_OUT)
		#tween.set_trans(Tween.TRANS_CUBIC)
		#tween.tween_property(self, "position", target_position, 0.5)
	#
	#
#func _die() -> void:
	#is_alive = false
	##animated_sprite_2d.play("death")
	#
	## Dawson - Adds 1 Gold to the Global Gold count
	#PlayerStats.Gold += 1
	## Dawson - Spawns the exit staircase
	#allEnemiesDead.emit()
	#
	##disable collision
	#$DamageTrigger/CollisionShape2D.set_deferred("disabled", true)
	#$Sight/CollisionShape2D.set_deferred("disabled", true)
	#hide()
	#
#
#func _on_sight_body_entered(body: Node2D) -> void:
	##print(body.name)
	#if body.name == "SwordEnemy":
		#target = body
	#player=body
	#player_chase = true
#
#func _on_sight_body_exited(body: Node2D) -> void:
	#player=null
	#player_chase=false
	#if body.name == "SwordEnemy" and is_alive:
		#target = null
		##animated_sprite_2d.play("idle_front")
#
##The function that gives the damage to the player
#func get_damage():
	#return damage
#
#func _on_damage_trigger_area_entered(area: Area2D) -> void:
	#if(player):
		#take_damage(20,player.position)
	#else:
		#take_damage(20,Vector2.ZERO)

extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $rotationNode/AnimatedSprite2D
@onready var rotation_node: Node2D = $rotationNode
@onready var arrow_start_marker: Marker2D = $rotationNode/arrowStartMarker

const ARROW = preload("uid://ccknvsbk3xdax")

const SPEED = 150.0
const JUMP_VELOCITY = -400.0

var isShooting = false
var inRange = false
var playerNode = null

func _physics_process(delta: float) -> void:
	if playerNode:
		_shoot()
	else:
		animated_sprite_2d.play("Idle")
	_set_animation()

func _shoot():
	isShooting = true
	animated_sprite_2d.play("Attack")

func _set_animation():
	var playerNode
	
	if not playerNode: 
		
		return
	
	var playerPosition = playerNode.global_position
	var direction = global_position.direction_to(playerPosition)
	
	if direction.x > 0:
		rotation_node.scale.x = 1
	elif direction.x < 0:
		rotation_node.scale.x = -1

func _on_animated_sprite_2d_frame_changed() -> void:
	if animated_sprite_2d.animation == "Attack":
		if animated_sprite_2d.frame == 5:
			_create_arrow()
			
func _create_arrow():
	var arrowNode = ARROW.instantiate()
	
	var playerNode
	arrowNode.direction = global_position.direction_to(playerNode.global_position)
	
	get_tree().current_scene.add_child(arrowNode)
	arrowNode.global_position = arrow_start_marker.global_position


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "Attack":
		isShooting = false
	animated_sprite_2d.play("Idle")

func _on_sight_area_entered(body: Area2D) -> void:
	print(body.name)
	if body.name == "SwordEnemy":
		playerNode = body
		inRange = true
	playerNode = body


func _on_sight_area_exited(body: Area2D) -> void:
	if body.name == "SwordEnemy":
		playerNode = null
		inRange = false
		animated_sprite_2d.player("Idle")

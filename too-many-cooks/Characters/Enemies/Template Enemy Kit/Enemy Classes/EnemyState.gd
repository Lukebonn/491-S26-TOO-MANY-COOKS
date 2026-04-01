class_name EnemyState extends Node
#code mostly copied from owen player state
#but this should work for enemies

#steps for making a new enemy state:
#1: add a new EnemyState node to TemplateEnemy.tscm
#2: name it what it does (ex: dash_state, shoot_projectile_state, etc)
#3: hit the script button on this new node and make a new script
#   this should make the script on the node white instead of gray)
#4: code in that, you can reference everything in here

##holds the Enemy node (essentially the parent)
var enemy_ref
##holds the player ref (if we have one)
var player_ref
##the animated sprite 2d will try to play the animation name of this name (put "NONE" if there is not one)
@export var animation_name : String
##code that should execute when entering state
func enter_state(enemy_node):
	enemy_ref = enemy_node
	player_ref = enemy_ref.player_ref
	if animation_name != "NONE":
		$AnimatedSprite2D.animation = animation_name

##code that should execute when exiting state
func exit_state():
	pass

##code that should execute when this enemy gets hit
#source = the node that causes the damage
func hit_response(source):
	pass

func process(delta):
	pass

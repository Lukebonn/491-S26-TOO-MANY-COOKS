extends Node

##enemy stats go here and are referenced by calling EnemyStats.variable_name
#lets also use capital letters for these vars since they public
#also comment the intended use for each variable
#make sure they are typed variables too, most will be floats

#NOTE: health of all enemies
var basic_slime_health = 100
var basic_ranged_enemy_health = 100
var basic_hob_lobber_health = 100

#NOTE: damage of all enemies

#NOTE: speed of all enemies

#NOTE: attack cooldown times of all enemies

#ok, I had a bit of fun with this one, so please chnage name if needed
var airtime_of_lob_thrown_by_hob_lobber = 2
#there is currently only one enemy throwing a AoE attack, 
#so variable may need to change in the future
var duration_of_poison_lobbed_by_hob_lobber = 10

##NOTE: number enemies in a room
var enemies_in_room = 0

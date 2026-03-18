extends Node
##player stats go here and are referenced by calling PlayerStats.variable_name
#lets also use capital letters for these vars since they public
#also comment the intended use for each variable
#make sure they are typed variables too, most will be floats

##temp resource to track currency for tavern upgrades, will likely be changed. collected from enemies for now
var Gold := 0

##speed stats for the player
var Max_Speed = 200.0
var Speed_Slowdown = 150.0

##health and mana, 
#these are directly edited from tavern upgrades
#but in gameplay realtime health and mana
#is edited in the player (not here)
var MaxHealth := 100.0
var MaxMana := 100.0

##base player stats without any items for class modifiers
#currently have no effect in game
var base_str : int = 10
var base_def : int = 10
var base_spd : int = 10
var base_mag : int = 10

##magic type, this correlates to what spell is cast
#set to none for the playtest1 at first
# Possible magic types:
# None = no magic
# Fireball = projectile
# Regen = regeneration spell for 5 seconds (not in)
var Magic := "None"

##classes enum for all possible classes and current_class for the player's equipped class
var current_class = classes.warrior

enum classes{
	none,
	warrior,
	ranger,
	mage
}

extends Node
##player stats go here and are referenced by calling PlayerStats.variable_name
#lets also use capital letters for these vars since they public
#also comment the intended use for each variable
#make sure they are typed variables too, most will be floats

##temp resource to track currency for tavern upgrades, will likely be changed. collected from enemies for now
var Gold := 999
var Orbs : int = 999
#Gold/Orbs when entering floor, reverted back to on Retry to avoid infinite farm.
var temp_gold : int = 0
var temp_orb : int = 0

##speed stats for the player
#var Max_Speed = 200.0
#var Speed_Slowdown = 150.0

##health and mana, 
#these are directly edited from tavern upgrades
#but in gameplay realtime health and mana
#is edited in the player (not here)
var MaxHealth := 100.0
var MaxMana := 100.0

##base player stats without any items for class modifiers
var base_str : int = 10
var base_def : int = 10
var base_spd : int = 10
var base_mag : int = 10

##passive player stats that have been upgraded
#set from tavern either upgrading a class or fixing a tavernpiece
var passive_str : int = 0
var passive_def : int = 0
var passive_spd : int = 0
var passive_mana : int = 0
var passive_hp : int = 0

##magic type, this correlates to what spell is cast
#set to none for the playtest1 at first
# Possible magic types:
# None = no magic
# Fireball = projectile
# Regen = regeneration spell for 5 seconds (not in)
var Magic := "None"

##classes enum for all possible classes and current_class for the player's equipped class
var current_class = classes.mage

enum classes{
	none,
	warrior,
	rogue,
	mage
}

##"achievement" stats that go up and determine class avaliablity... among other things?
var KillCount : int = 0

#variables to track how many enemies are killed during quests
var Quest1EnemiesKOs : int = 0
var Quest1Orbs : int = 0

#variable to track how many quests we have
var quests : int = 0

#vars to track NPC class levels, read by the class NPCs on tavern load
var MeleeClassLevel : int = 1
var MageClassLevel : int = 1
var RogueClassLevel : int = 1
#same but for abilities
var MeleeClassAbilityLevel : int = 1
var MageClassAbilityLevel : int = 1
var RogueClassAbilityLevel : int = 1

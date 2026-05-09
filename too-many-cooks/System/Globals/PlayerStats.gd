extends Node
##player stats go here and are referenced by calling PlayerStats.variable_name
#lets also use capital letters for these vars since they public
#also comment the intended use for each variable
#make sure they are typed variables too, most will be floats

##global reference for the player
var player_ref : CharacterBody2D

##temp resource to track currency for tavern upgrades, will likely be changed. collected from enemies for now
var Gold := 0
var Orbs : int = 0
#Gold/Orbs when entering floor, reverted back to on Retry to avoid infinite farm.
var Floor_Gold : int = 0 #prev temp_gold
var Floor_Orbs : int = 0 #prev temp_orbs

var Player_Damage_Dealt: int = 0 # Damage the player has dealt to enemies
var Enemy_Damage_Dealt: int = 0 # Damage enemies have dealt to the player
var Enemies_Defeated: int = 0 # Number of enemies defeated in level

##speed stats for the player
#var Max_Speed = 200.0
#var Speed_Slowdown = 150.0

##inventory item cache
#this is meant to only be a temporary storage area for these kind of level exclusive variables
#these variables will be reset whenever the player switches to a new scene by default
#just so that the complexity of this variable doesn't outweigh any existing persistence and for simplicity
##types of keys the player can pick up in a level
enum KeyType {
	BLOOD,
	GOLD,
	JADE,
	CRYSTAL,
	IRON
} #son what is this

##erased at the beginning of every scene IMPORTANT (for now)
var keys: Array[KeyType] = []

func add_key(key: KeyType) -> void:
	if key not in keys:
		keys.append(key)

func has_key(key: KeyType) -> bool:
	return key in keys

func remove_key(key: KeyType) -> void:
	keys.erase(key)

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

##refrence to the ability icon bar in the UI
var icon_bar

##"achievement" stats that go up and determine class avaliablity... among other things?
var KillCount : int = 0

var level_kill_count : int
var has_not_dashed : bool
var no_damage : bool
var coins_collected : int
var speedrun_under_60 : bool
var speedrun_under_90 : bool
var speedrun_under_120 : bool

#vars to track NPC class levels, read by the class NPCs on tavern load
var MeleeClassLevel : int = 1
var MageClassLevel : int = 1
var RogueClassLevel : int = 1
#same but for abilities
var MeleeClassAbilityLevel : int = 0
var MageClassAbilityLevel : int = 0
var RogueClassAbilityLevel : int = 0

func reset_objective_stats():
	level_kill_count = 0
	coins_collected = 0
	has_not_dashed = true
	no_damage = true
	speedrun_under_60 = true
	speedrun_under_90 = true
	speedrun_under_120 = true

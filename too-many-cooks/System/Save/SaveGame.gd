class_name SaveGame
extends Resource

# The current amount of Gold the player has, intended for playtest progression.
@export var gold_count := 0

# The current level of the Tavern.
# Starts at 0 for Level 1, then incriments (1=Lv2, etc.).
@export var tavern_level := 0

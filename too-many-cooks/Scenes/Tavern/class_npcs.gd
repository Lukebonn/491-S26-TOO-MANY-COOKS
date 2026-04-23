extends Control
@onready var warrior = $Warrior_CLASS_NPC
@onready var mage = $Mage_CLASS_NPC
@onready var rogue = $Rogue_CLASS_NPC

func calculate_passive_stats():
	PlayerStats.passive_str = warrior.new_passive_str + mage.new_passive_str +rogue.new_passive_str 
	#PlayerStats.passive_def = warrior.Passive_Defense
	PlayerStats.passive_spd = warrior.new_passive_spd + mage.new_passive_spd + rogue.new_passive_spd
	PlayerStats.passive_mana = warrior.new_passive_mana + mage.new_passive_mana + rogue.new_passive_mana
	PlayerStats.passive_hp = warrior.new_passive_hp + mage.new_passive_hp + rogue.new_passive_hp
	print("Passive strength is... " + str(PlayerStats.passive_str))
	print("Passive speed is... " + str(PlayerStats.passive_spd))
	print("Passive mana is... " + str(PlayerStats.passive_mana))
	print("Passive health is... " + str(PlayerStats.passive_hp))

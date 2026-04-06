extends Node

func _ready():
	for node in get_children():
		node.connect("Upgrade_Basic",_on_upgrade_basic)
		node.connect("Upgrade_Complicated",_on_upgrade_complicated)

func _on_upgrade_basic(stat, boost):
	match stat:
		"attack":
			PlayerStats.passive_str += boost
		"defense":
			PlayerStats.passive_def += boost
		"speed":
			PlayerStats.passive_spd += boost
		"mana":
			PlayerStats.passive_mana += boost
		"hp":
			PlayerStats.passive_hp += boost

func _on_upgrade_complicated(variant):
	#thinking about it now most of the upgrade things 
	#that are complex will likely be from npcs
	#oh well...
	match variant:
		"NPCMagic":
			$"../ROGUE".show()
			$NPCEnd.show()
			$"../TavernBackgroundLong".hide()
			$"../TavernBackgroundLong2".show()
			
		"NPCEnd":
			$"../PLAYTEST".show()
			$"../TavernBackgroundLong2".hide()
			$"../TavernBackgroundLong3".show()

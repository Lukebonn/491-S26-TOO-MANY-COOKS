extends Node2D

var current_spell : String = "ice"

func cycle_up():
	match current_spell:
		"ice":
			current_spell = "fire"
			change_sprites("res://Characters/Player/Sprites/Spells/fire_indicator_large1.png", 
			"res://Characters/Player/Sprites/Spells/ice_indicator_small1.png", 
			"res://Characters/Player/Sprites/Spells/vortex_indicator_small1.png")
		"fire":
			current_spell = "vortex"
			change_sprites("res://Characters/Player/Sprites/Spells/vortex_indicator_large1.png",
			"res://Characters/Player/Sprites/Spells/fire_indicator_small1.png",
			"res://Characters/Player/Sprites/Spells/ice_indicator_small1.png")
		"vortex":
			current_spell = "ice"
			change_sprites("res://Characters/Player/Sprites/Spells/ice_indicator_large1.png",
			"res://Characters/Player/Sprites/Spells/vortex_indicator_small1.png",
			"res://Characters/Player/Sprites/Spells/fire_indicator_small1.png")

func cycle_down():
	match current_spell:
		"ice":
			current_spell = "vortex"
			change_sprites("res://Characters/Player/Sprites/Spells/vortex_indicator_large1.png",
			"res://Characters/Player/Sprites/Spells/fire_indicator_small1.png",
			"res://Characters/Player/Sprites/Spells/ice_indicator_small1.png")
		"vortex":
			current_spell = "fire"
			change_sprites("res://Characters/Player/Sprites/Spells/fire_indicator_large1.png", 
			"res://Characters/Player/Sprites/Spells/ice_indicator_small1.png", 
			"res://Characters/Player/Sprites/Spells/vortex_indicator_small1.png")
		"fire":
			current_spell = "ice"
			change_sprites("res://Characters/Player/Sprites/Spells/ice_indicator_large1.png",
			"res://Characters/Player/Sprites/Spells/vortex_indicator_small1.png",
			"res://Characters/Player/Sprites/Spells/fire_indicator_small1.png")

func change_sprites(equipped : String, last : String, next : String):
	$EquippedSpell.texture = load(equipped)
	$LastSpell.texture = load(last)
	$NextSpell.texture = load(next)

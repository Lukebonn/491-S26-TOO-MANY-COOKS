extends Control

var player: Node # stores a reference to the player node in the Combat Scene.
@export var settings: Node2D
@export var key_sprites: Array[Texture2D]
var pauseDisabled = false
var objective = 0
var warrior_objective = 0
var rogue_objective = 0
var mage_objective = 0

signal flashManaBar()

var warrior_quest_1 = "Quest: Kill 10 enemies"

var mage_quest_1 = "Quest: Get an orb"
signal update_health_bar
signal update_mana_bar

#allows the ability to toggle visibility of the key depending on how many and which keys are in inventory
var current_visible_keys: int = 0
@onready var key_1: Sprite2D = $KeysHeld/Key1
@onready var key_2: Sprite2D = $KeysHeld/Key2
@onready var key_3: Sprite2D = $KeysHeld/Key3
@onready var key_4: Sprite2D = $KeysHeld/Key4
@onready var key_5: Sprite2D = $KeysHeld/Key5
@onready var key_slots: Array[Sprite2D] = [
	$KeysHeld/Key1,
	$KeysHeld/Key2,
	$KeysHeld/Key3,
	$KeysHeld/Key4,
	$KeysHeld/Key5
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for key in key_slots:
		key.hide()
	settings.in_menu = false
	$DeathScreen.visible = false
	if $"../../Player":
		player = $"../../Player"
		#player.connect("notEnoughMana", _on_player_not_enough_mana)
		
		#catch case, we don't want "You Died!" screen in intro combat
		if get_tree().current_scene.name != "IntroCombat":
			player.connect("playerDeath", _on_player_death)
		#print("hi")
	show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause") and (not settings.in_settings_menu) and (not pauseDisabled):
		pauseDisabled = true
		if settings.in_menu == true:
			settings.do_settings_action("hide_menu")
		else:
			settings.do_settings_action("show_menu")
		get_tree().create_timer(1, true).timeout.connect(on_pause_cooldown_finished)
	if settings.in_menu == true: get_tree().paused = true
	else: get_tree().paused = false
	if player:
		# ensures that the player's Health can only ever be between
		# 0 and the player's Max Health.
		player.health = clamp(player.health, 0, PlayerStats.MaxHealth)
		player.mana = clamp(player.mana, 0, PlayerStats.MaxMana)
		
		player.displayHealth = int(round(player.health))
		player.displayMana = int(player.mana)
		# updates the values for displayHealth & displayMana 
		# to display as integers.
		quest_received()
	##will check every frame whether or not there is a chnage in the key array, if there is it will remove a sprite from the listing
	current_visible_keys = 0
	for i in range(PlayerStats.keys.size()):
		var sprite = key_slots[i]
		sprite.show()
		sprite.texture = key_sprites[PlayerStats.keys[i]]
	for i in range(5):
		var sprite = key_slots[i]
		if sprite.visible:
			current_visible_keys += 1
	while (PlayerStats.keys.size() < current_visible_keys):
		key_slots[current_visible_keys-1].hide()
		current_visible_keys -= 1
	
	
	# testing purposes
	#print(statusEffects)
	#print(effectDurations)
	
	
func _on_player_not_enough_mana() -> void:
	flashManaBar.emit()
	# this signal tells the Mana bar to flash, indicating to the
	# player that they do not have enough Mana.
# Takes a singal and emits another signal that is more local to the
# Mana bar node. Yes, it might be redundant to emit a signal from
# another signal, but I couldn't think of another way to do this.

func _on_player_death() -> void:
	await get_tree().create_timer(1.0).timeout
	$DeathScreen.visible = true
	# When the player unfortunately passes away, 
	# wait 1 second, then display the death screen.

func _on_retry_button_button_down() -> void:
	#PlayerStats.Gold = PlayerStats.temp_gold
	#PlayerStats.Orbs = PlayerStats.temp_orb
	PlayerStats.Gold -= PlayerStats.Floor_Gold
	PlayerStats.Orbs -= PlayerStats.Floor_Orbs
	PlayerStats.Floor_Gold = 0
	PlayerStats.Floor_Orbs = 0
	get_tree().reload_current_scene()
	# restarts the combat scene


func _on_return_button_button_down() -> void:
	PlayerStats.Gold -= PlayerStats.Floor_Gold
	PlayerStats.Orbs -= PlayerStats.Floor_Orbs
	PlayerStats.Floor_Gold = 0
	PlayerStats.Floor_Orbs = 0
	get_tree().change_scene_to_file("res://Scenes/Tavern/tavern.tscn")
	# takes the player back to the tavern

func quest_received():
	if Global.Has_Warrior_Quest_1:
		$Quest.set_text(warrior_quest_1 + " %d / 10" % [PlayerStats.Quest1EnemiesKOs])
		if PlayerStats.Quest1EnemiesKOs >= 10:
			$Quest.set_text("Quest complete! Talk to Warrior!")
	if Global.Has_Mage_Quest_1:
		$Quest.set_text(mage_quest_1 + " %d / 1" % [PlayerStats.Quest1Orbs])
		if PlayerStats.Quest1Orbs >= 1:
			$Quest.set_text("Quest complete! Talk to Mage!")
	if PlayerStats.quests > 1:
		if $Quest.text == (mage_quest_1 + " %d / 1" % [PlayerStats.Quest1Orbs]):
			$Quest2.set_text(warrior_quest_1 + " %d / 10" % [PlayerStats.Quest1EnemiesKOs])
			if PlayerStats.Quest1EnemiesKOs >= 10:
				$Quest2.set_text("Quest complete! Talk to Warrior!")
		elif $Quest.text == (warrior_quest_1 + " %d / 10" % [PlayerStats.Quest1EnemiesKOs]):
			$Quest2.set_text(mage_quest_1 + " %d / 1" % [PlayerStats.Quest1Orbs])
			if PlayerStats.Quest1Orbs >= 1:
				$Quest2.set_text("Quest complete! Talk to Mage!")

func _on_pause_retry_button_down() -> void:
	get_tree().paused = false
	PlayerStats.Gold = PlayerStats.temp_gold
	PlayerStats.Orbs = PlayerStats.temp_orb
	get_tree().reload_current_scene()


func _on_retry_return_button_down() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Tavern/tavern.tscn")

func on_pause_cooldown_finished() -> void:
	pauseDisabled = false


func _on_exit_current_health() -> void:
	update_health_bar.emit()


func _on_exit_current_mana() -> void:
	update_mana_bar.emit()

func _level_objective() -> void:
	objective = randi() % 7
	if Global.Warrior_Objective == true:
		warrior_objective = randi() % 7
	if Global.Rogue_Objective == true:
		rogue_objective = randi() % 7
	if Global.Mage_Objective == true:
		mage_objective = randi() % 7
	if objective == 0:
		pass
	elif objective == 1:
		pass
	elif objective == 2:
		pass
	elif objective == 3:
		pass
	elif objective == 4:
		pass
	elif objective == 5:
		pass
	elif objective == 6:
		pass

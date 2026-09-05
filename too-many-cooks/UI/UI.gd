extends Control

var player: Node # stores a reference to the player node in the Combat Scene.
@export var settings: Node2D
@export var tavern_warning: Node2D
@export var level_review: Node2D
@export var key_sprites: Array[Texture2D]
var pauseDisabled = false
var level_complete = false
var player_dead = false
var objective = 0
var warrior_objective = 0
var rogue_objective = 0
var mage_objective = 0

signal flashManaBar()

signal update_health_bar
signal update_mana_bar

signal level_is_complete

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
	PlayerStats.reset_objective_stats()
	PlayerStats.Player_Damage_Dealt = 0
	PlayerStats.Enemy_Damage_Dealt = 0
	PlayerStats.Enemies_Defeated = 0
	Global.connect("disableTimer", _on_disable_timer)
	if not Global.timerEnabled:
		$"HUD Timer".visible = false
	#level_complete = false
	#pauseDisabled = false
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
	
	#loads the correct ability bar UI
	var ability_bar : Node
	
	match PlayerStats.current_class:
		PlayerStats.classes.none:
			ability_bar = load("res://UI/BattleHUD/AbilityIcons/blank_class_icon_bar/blank_ability_icons.tscn").instantiate()
		PlayerStats.classes.warrior:
			ability_bar = load("res://UI/BattleHUD/AbilityIcons/warrior_icon_bar/warrior_ability_icons.tscn").instantiate()
		PlayerStats.classes.mage:
			ability_bar = load("res://UI/BattleHUD/AbilityIcons/mage_icon_bar/mage_ability_icons.tscn").instantiate()
		PlayerStats.classes.rogue:
			ability_bar = load("res://UI/BattleHUD/AbilityIcons/rogue_icon_bar/ranger_icon_bar.tscn").instantiate()
		_:
			ability_bar = load("res://UI/BattleHUD/AbilityIcons/blank_class_icon_bar/blank_ability_icons.tscn").instantiate()
	
	add_child(ability_bar)
	ability_bar.position = $AbilityBarPosition.position
	
	show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("debug_gold"):
		PlayerStats.Gold += 100
	if Input.is_action_just_pressed("debug_orbs"):
		PlayerStats.Orbs += 5
	if Input.is_action_just_pressed("pause") and (not player_dead) and (not settings.in_settings_menu) and (not tavern_warning.warning_prompted) and (not pauseDisabled):
		pauseDisabled = true
		if settings.in_menu == true:
			settings.do_settings_action("hide_menu")
			$"Objective Name".modulate = Color(1,1,1,0)
		else:
			settings.do_settings_action("show_menu")
			$"Objective Name".modulate = Color(1,1,1,1)
		get_tree().create_timer(1, true).timeout.connect(on_pause_cooldown_finished)
	if settings.in_menu or level_complete: get_tree().paused = true
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
	player_dead = true
	$DeathScreen.visible = true
	if $"../../CombatMusic":
		$"../../CombatMusic".stop()
		$"Death Sound".play()
	var tween = $DeathScreen.create_tween()
	tween.tween_property(
		$DeathScreen, 
		"color",
		Color(0.10, 0.1, 0.1, 0.58),
		1).set_trans(Tween.TRANS_LINEAR)
	#await get_tree().create_timer(1.0).timeout
	await tween.finished
	$"Death Song".play()
	var tween2 = $DeathScreen.create_tween()
	var text_tween = $DeathScreen/DeathText.create_tween()
	var retry_tween = $DeathScreen/RetryButton.create_tween()
	tween2.tween_property(
		$DeathScreen, 
		"color",
		Color(0.6, 0.0, 0.0, 0.5),
		3).set_trans(Tween.TRANS_LINEAR)
		# color (0.10, 0.10, 0.10, 0.58)
	
	text_tween.tween_property(
		$DeathScreen/DeathText, 
		"position",
		Vector2($DeathScreen/DeathText.position.x, 100),
		1).set_trans(Tween.TRANS_EXPO)
	
	retry_tween.tween_property(
		$DeathScreen/RetryButton, 
		"position",
		Vector2($DeathScreen/RetryButton.position.x, 256.0),
		1).set_trans(Tween.TRANS_EXPO)
	await get_tree().create_timer(0.1).timeout
	var return_tween = $DeathScreen/ReturnButton.create_tween()
	return_tween.tween_property(
		$DeathScreen/ReturnButton, 
		"position",
		Vector2($DeathScreen/ReturnButton.position.x, 360.0),
		1).set_trans(Tween.TRANS_EXPO)
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
	get_tree().paused = false
	PlayerStats.Gold -= PlayerStats.Floor_Gold
	PlayerStats.Orbs -= PlayerStats.Floor_Orbs
	PlayerStats.Floor_Gold = 0
	PlayerStats.Floor_Orbs = 0
	LevelQueue.Queue.clear()
	get_tree().change_scene_to_file("res://Scenes/Tavern/tavern.tscn")
	# takes the player back to the tavern

func on_pause_cooldown_finished() -> void:
	pauseDisabled = false


func _on_exit_current_health() -> void:
	update_health_bar.emit()


func _on_exit_current_mana() -> void:
	update_mana_bar.emit()

func _on_level_complete() -> void:
	level_is_complete.emit()
	level_complete = true
	pauseDisabled = true
	$TimeMachine.stop()
	if $"../../CombatMusic":
		$"../../CombatMusic".stop()
	level_review.reveal()


func _on_advance_button_pressed() -> void:
	level_complete = false
	LevelQueue.load_level()

func _on_return_button_pressed() -> void:
	settings.show_warning_menu.emit()


func _on_objective_manager_ui_objective(objective_title: Variant) -> void:
	if Global.First_Time_Tavern:
		$"Objective Name".hide()
	$"Objective Name".set_text("Objective\n" + objective_title)
	var tween = get_tree().create_tween()
	tween.tween_property($"Objective Name","modulate",Color(1,1,1,0),5.0)

func _on_disable_timer() -> void:
	if Global.timerEnabled:
		$"HUD Timer".visible = true
	else:
		$"HUD Timer".visible = false

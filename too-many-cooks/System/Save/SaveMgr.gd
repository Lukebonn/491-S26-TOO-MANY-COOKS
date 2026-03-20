extends Node
const SavePath = "res://System/Save/SaveGame.tres"
var GameData: SaveGame = null

# Attempt to load SaveGame via Load().
func _ready() -> void:
	Load()

# Save game data, creating a new SaveGame if one doesn't exist.
func Save() -> void:
	if ResourceLoader.exists(SavePath):
		GameData = SaveGame.new()
	ResourceSaver.save(GameData, SavePath)

# Load game save, calling Save() if one doesn't exist.
func Load() -> void:
	if ResourceLoader.exists(SavePath):
		GameData = ResourceLoader.load(SavePath, "", ResourceLoader.CACHE_MODE_IGNORE)
	else:
		GameData = SaveGame.new()

# Delete save data and create new data with Save().
func Reset() -> void:
	if ResourceLoader.exists(SavePath):
		DirAccess.remove_absolute(SavePath)
	Save()

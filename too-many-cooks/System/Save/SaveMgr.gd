extends Node
const SavePath = "res://System/Save/SaveGame.tres"
var GameSave: SaveGame = null

# Attempt to load SaveGame via Load().
func _ready() -> void:
	Load()

# Save game data, creating a new SaveGame if one doesn't exist.
func Save() -> void:
	if ResourceLoader.exists(SavePath):
		GameSave = SaveGame.new()
	ResourceSaver.save(GameSave, SavePath)

# Load game save, calling Save() if one doesn't exist.
func Load() -> void:
	if ResourceLoader.exists(SavePath):
		GameSave = ResourceLoader.load(SavePath, "", ResourceLoader.CACHE_MODE_IGNORE)
	else:
		GameSave = SaveGame.new()

# Delete save data and create new data with Save().
func Reset() -> void:
	if ResourceLoader.exists(SavePath):
		DirAccess.remove_absolute(SavePath)
	Save()

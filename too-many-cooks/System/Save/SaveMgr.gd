extends Node
const SavePath = "res://System/Save/SaveGame"
var GameData: SaveGame = null
var SaveIndex: int = 0
var SaveSlotPath: String

# Attempt to load SaveGame via Load().
func _ready() -> void:
	SetSaveSlot(0)
	Load()

# Set save slot to operate with.
# Should only be called from title screen.
func SetSaveSlot(slot: int):
	SaveIndex = slot
	SaveSlotPath = SavePath + str(SaveIndex) + ".tres"

# Save game data, creating a new SaveGame if one doesn't exist.
func Save() -> void:
	if ResourceLoader.exists(SaveSlotPath):
		GameData = SaveGame.new()
	ResourceSaver.save(GameData, SaveSlotPath)

# Load game save, calling Save() if one doesn't exist.
func Load() -> void:
	if ResourceLoader.exists(SaveSlotPath):
		GameData = ResourceLoader.load(SaveSlotPath, "", ResourceLoader.CACHE_MODE_IGNORE)
	else:
		GameData = SaveGame.new()
		Save()

# Delete save data and create new data with Save().
func Reset() -> void:
	if ResourceLoader.exists(SaveSlotPath):
		DirAccess.remove_absolute(SaveSlotPath)
	Save()

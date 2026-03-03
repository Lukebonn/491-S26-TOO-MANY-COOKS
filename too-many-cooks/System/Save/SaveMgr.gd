extends Node
const SavePath = "res://System/Save/SaveGame.tres"
var GameSave: SaveGame = null

func _ready() -> void:
	if ResourceLoader.exists(SavePath):
		GameSave = ResourceLoader.load(SavePath, "", ResourceLoader.CACHE_MODE_IGNORE)
	else:
		GameSave = SaveGame.new()

func Save() -> void:
	ResourceSaver.save(GameSave, SavePath)

extends Node2D

func _ready() -> void:
	print(ResourceLoader.exists("res://System/Save/SaveGame.tres"))

#On enemies dead, open door.
func _on_obj_enemy_spawner_on_spawn() -> void:
	$OnDeadOpenDoor/ObjDoor2.set_open(false)
func _on_obj_enemy_spawner_on_all_dead() -> void:
	$OnDeadOpenDoor/ObjDoor2.set_open(true)

#Unlock door with key.
func _on_obj_lock_on_unlock() -> void:
	$UnlockDoorWithKey/ObjDoor.set_open(true)

#On enemies dead, give key to unlock chest.
func _on_obj_enemy_spawner_2_on_all_dead() -> void:
	$OnDeadGiveKey/ObjKey2.visible = true
func _on_obj_lock_2_on_unlock() -> void:
	$OnDeadGiveKey/ObjChest.open_chest()

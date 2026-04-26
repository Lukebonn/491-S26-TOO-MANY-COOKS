extends Node2D
signal on_chest_opened

var opened = false
#Whether or not this chest is open.
var animRef : AnimationPlayer
#Ref to AnimationPlayer.
var spriteRef : Sprite2D
#Ref to Sprite2D.

@export var Drops: Array[PickupData] = []

func _ready() -> void:
	animRef = $AnimationPlayer
	spriteRef = $Sprite2D

func open_chest():
	opened = true
	animRef.play("open")
	on_chest_opened.emit()
	for drop in Drops:
		var c = randf_range(0.0, 1.0)
		if drop.DropChance >= c:
			var i = int(randf_range(drop.DropCountRange.x, drop.DropCountRange.y))
			for d in i:
				var inst = drop.SceneToSpawn.instantiate()
				inst.global_position = global_position
				get_parent().add_sibling(inst)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player" && not opened:
		open_chest()

extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# disables the staircase & collision areas until all enemies are defeated
	visible = false
	$TavernReturn.set_deferred("disabled", true)
	$TavernReturn/CollisionShape2D.set_deferred("disabled", true)

func _on_all_enemies_dead() -> void:
	# enables the staircase & collision areas once all enemies are defeated
	visible = true
	$TavernReturn.set_deferred("disabled", false)
	$TavernReturn/CollisionShape2D.set_deferred("disabled", false)

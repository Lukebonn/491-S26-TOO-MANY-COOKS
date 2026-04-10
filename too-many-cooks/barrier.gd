extends StaticBody2D
var player = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass




func _on_area_2d_area_entered(area: Area2D):
	player = area
	if(player):
		$CollisionShape2D.set_deferred("disabled", true)
		hide()

extends Area2D

var speed = 100
var direction: Vector2

@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready():
	set_as_top_level(true)
	get_tree().create_timer(2).timeout.connect(queue_free)
	
func _process(delta: float) -> void:
	if direction:
		global_position += direction * speed * delta
		look_at(global_position + direction)
	


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if(body.name == "SwordEnemy"):
		#body.take_damage(20, player.position)
		print("Player Hit!")
	else:
		pass
	queue_free()

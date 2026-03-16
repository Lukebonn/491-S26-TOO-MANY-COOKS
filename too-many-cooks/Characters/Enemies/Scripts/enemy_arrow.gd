extends Area2D

var speed = 100
var direction: Vector2


@export var damage = 10
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

#queue_free is used to clear the arrow off the screen after hitting the player
func _on_area_entered(area: Area2D) -> void:
	if(area.name == "Hurtbox"):
		print("Player Hit!")
		queue_free()
	else:
		pass
	queue_free()

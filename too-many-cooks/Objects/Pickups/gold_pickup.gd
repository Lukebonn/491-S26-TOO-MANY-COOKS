extends Pickup
var done_landing = false
func _ready():
	$Area2D.connect("body_entered",collect)
	$sight.connect("body_entered",nav_to_player)
	velocity = spawn_velocity()
	var tween = get_tree().create_tween().set_parallel(true)
	tween.tween_property(self,"velocity",Vector2(0,(velocity.y*-1)/2),.5)
	tween.tween_property(self,"rotation",720,.5)
	await tween.finished
	done_landing = true
	velocity = Vector2.ZERO
	rotation = 0

func _process(delta):
	position += velocity
	if target:
		position = position.lerp(target.position, weight)
		weight += delta
	move_and_slide()

func collect(body):
	PlayerStats.Gold += Value
	queue_free()

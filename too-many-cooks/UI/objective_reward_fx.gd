extends Sprite2D
@export var currency_data : String
func _ready():
	scale = Vector2(4,4)
	go_up()

func go_up():
	var tween = self.create_tween()
	var x = randf_range(0, 0)
	var y = randf_range(0, 0)
	tween.tween_property(self,"position",Vector2(self.position.x+x,self.position.y+y),.6).set_trans(Tween.TRANS_EXPO)
	await tween.finished
	go_to_origin()
	
func go_to_origin():
	var tween = self.create_tween()
	var x = 47.5
	var y = 184.0
	tween.set_parallel(true)
	tween.tween_property(self,"global_position",Vector2(x,y),.5).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self,"scale",Vector2(.5,.5),.5).set_trans(Tween.TRANS_CUBIC)
	await tween.finished
	destroy_self()
	
func destroy_self():
	match currency_data:
		"orb":
			PlayerStats.Orbs += 1
		"gold":
			PlayerStats.Gold += 50
	queue_free()

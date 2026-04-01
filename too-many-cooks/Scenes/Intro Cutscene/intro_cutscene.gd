extends Control

var can_turn_page = true
var current_page = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	FadeInFadeOut.fade_in()
	turn_to_page(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_anything_pressed():
		turn_to_page(current_page)

func turn_to_page(index: int):
	if can_turn_page and current_page < 5:
		var tween = get_tree().create_tween()
		tween.tween_property($Subtitles.get_child(index-1),"position",Vector2(76,1300),1).set_trans(Tween.TRANS_CUBIC)
		
		
		$Narrations.get_child(index).playing = false
		can_turn_page = false
		current_page += 1
		
		var narration = $Narrations.get_child(index)
		narration.play()
		
		var page = $Pages.get_child(index)
		var subtitle = $Subtitles.get_child(index)
		
		tween.set_parallel(true)
		tween.tween_property($PageArrow,"position",Vector2(1084,728),.2).set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(page,"position",Vector2(576,320),1).set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(subtitle,"position",Vector2(76,514),1).set_trans(Tween.TRANS_CUBIC)
		await tween.finished
		
		var arrow_tween = get_tree().create_tween()
		arrow_tween.tween_property($PageArrow,"position",Vector2(1084,584),.2).set_trans(Tween.TRANS_CUBIC)
		await arrow_tween.finished
		print("Finished page " + str(current_page))
		can_turn_page = true
	elif current_page == 5 and can_turn_page:
		FadeInFadeOut.fade_out()
		await get_tree().create_timer(1.2).timeout
		var target_scene = ResourceLoader.load("uid://dkpv4bqf7uhxt")
		get_tree().change_scene_to_packed(target_scene)

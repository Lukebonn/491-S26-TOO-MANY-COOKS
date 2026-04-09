extends Control

var can_advance_subtitle = true
var current_page = 0
var current_subtitle = 0

var narration
var page
var subtitle

# Called when the node enters the scene tree for the first time.
func _ready():
	FadeInFadeOut.fade_in()
	next_subtitle(0)
	#turn_to_page(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_anything_pressed():
		next_subtitle(current_subtitle)

#func turn_to_page(index: int):
	#if can_advance_page and current_page < 6:
		#if (not current_subtitle == 5):
			#var tween = get_tree().create_tween()
			#
			#can_advance_page = false
			#current_page += 1
			#
			#page = $Pages.get_child(index)
			#
			#tween.tween_property(page,"position",Vector2(576,320),1).set_trans(Tween.TRANS_CUBIC)
			#await tween.finished
			#
			#print("Finished page " + str(current_page))
			#can_advance_page = true
	#elif current_page == 6 and current_subtitle == 10 and can_advance_page:
		#FadeInFadeOut.fade_out()
		#await get_tree().create_timer(1.2).timeout
		#var target_scene = ResourceLoader.load("uid://dkpv4bqf7uhxt")
		#get_tree().change_scene_to_packed(target_scene)

func next_subtitle(index: int):
	if can_advance_subtitle and current_subtitle < 10:
		var tween = get_tree().create_tween()
		tween.tween_property($Subtitles.get_child(index-1),"position",Vector2(76,1300),1).set_trans(Tween.TRANS_CUBIC)
		
		$Narrations.get_child(index-1).playing = false
		can_advance_subtitle = false
		current_subtitle += 1
		
		narration = $Narrations.get_child(index)
		narration.play()
		
		subtitle = $Subtitles.get_child(index)
		
		tween.set_parallel(true)
		match current_subtitle:
			1:
				tween.tween_property(subtitle,"position",Vector2(76,514),1).set_trans(Tween.TRANS_CUBIC)
			2: # + Turn Page
				page = $Pages.get_child(0)
				tween.tween_property(page,"position",Vector2(576,320),1).set_trans(Tween.TRANS_CUBIC)
				
				tween.tween_property(subtitle,"position",Vector2(76,514),1).set_trans(Tween.TRANS_CUBIC)
			3: # + Adjusted Subtitle Vector
				tween.tween_property(subtitle,"position",Vector2(76,475),1).set_trans(Tween.TRANS_CUBIC)
			4: # + Turn Page
				page = $Pages.get_child(1)
				tween.tween_property(page,"position",Vector2(576,320),1).set_trans(Tween.TRANS_CUBIC)
				
				tween.tween_property(subtitle,"position",Vector2(76,514),1).set_trans(Tween.TRANS_CUBIC)
			5: # + Turn Page
				page = $Pages.get_child(2)
				tween.tween_property(page,"position",Vector2(576,320),1).set_trans(Tween.TRANS_CUBIC)
				
				tween.tween_property(subtitle,"position",Vector2(76,514),1).set_trans(Tween.TRANS_CUBIC)
			6: # + Adjusted Subtitle Vector
				tween.tween_property(subtitle,"position",Vector2(76,475),1).set_trans(Tween.TRANS_CUBIC)
			7: # + Turn Page | Adjusted Subtitle Vector
				page = $Pages.get_child(3)
				tween.tween_property(page,"position",Vector2(576,320),1).set_trans(Tween.TRANS_CUBIC)
				
				tween.tween_property(subtitle,"position",Vector2(76,475),1).set_trans(Tween.TRANS_CUBIC)
			8: # + Turn Page | Adjusted Subtitle Vector
				page = $Pages.get_child(4)
				tween.tween_property(page,"position",Vector2(576,320),1).set_trans(Tween.TRANS_CUBIC)
				
				tween.tween_property(subtitle,"position",Vector2(76,475),1).set_trans(Tween.TRANS_CUBIC)
			9: # + Turn Page | Adjusted Subtitle Vector
				page = $Pages.get_child(5)
				tween.tween_property(page,"position",Vector2(576,320),1).set_trans(Tween.TRANS_CUBIC)
				
				tween.tween_property(subtitle,"position",Vector2(76,475),1).set_trans(Tween.TRANS_CUBIC)
			10:
				tween.tween_property(subtitle,"position",Vector2(76,514),1).set_trans(Tween.TRANS_CUBIC)
		tween.tween_property($PageArrow,"position",Vector2(1084,728),.2).set_trans(Tween.TRANS_CUBIC)
		#tween.tween_property(subtitle,"position",Vector2(76,514),1).set_trans(Tween.TRANS_CUBIC)
		await tween.finished
		var arrow_tween = get_tree().create_tween()
		arrow_tween.tween_property($PageArrow,"position",Vector2(1084,584),.2).set_trans(Tween.TRANS_CUBIC)
		await arrow_tween.finished
		print("Finished subtitle " + str(current_subtitle))
		
		can_advance_subtitle = true
	elif current_subtitle == 10 and can_advance_subtitle:
		FadeInFadeOut.fade_out()
		await get_tree().create_timer(1.2).timeout
		var target_scene = ResourceLoader.load("uid://dkpv4bqf7uhxt")
		get_tree().change_scene_to_packed(target_scene)

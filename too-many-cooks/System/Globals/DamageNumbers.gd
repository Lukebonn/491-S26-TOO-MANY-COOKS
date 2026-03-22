extends Node

#idk if we want to add crit hits but i added it just in case
func display_number(value: int, position: Vector2): #is_crit: bool = false):
	var number = Label.new()
	number.global_position = position
	number.text = str(value)
	number.z_index = 5
	number.label_settings = LabelSettings.new()
	
	var color = "#FFF" #color = white (i think)
	#if is_crit:
		#color = "#B22" #red
	if value == 0:
		color = "#FFF8" #white
	
	number.label_settings.font_color = color
	number.label_settings.font_size = 12 #IDK a good size
	number.label_settings.outline_color = "#000" #black outline
	number.label_settings.outline_size = 1
	number.theme = preload("res://UI/Themes/CombatTheme.tres")
	number.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR
	
	call_deferred("add_child", number) #adds the number
	
	#await get_tree().process_frame
	#number.pivot_offset = number.size / 2
	await number.resized
	number.pivot_offset = Vector2(number.size / 2)
	
	#animates the number up and down
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(
		number, "position:y", number.position.y -24, 0.25
	) .set_ease(Tween.EASE_OUT)
	#animates number upward 24 pixels on .25 secs
	
	tween.tween_property(
		number, "position:y", number.position.y, 0.5
	).set_ease(Tween.EASE_IN).set_delay(0.25) #falling down animation
	
	tween.tween_property(
		number, "scale", Vector2.ZERO, 0.25
	).set_ease(Tween.EASE_IN).set_delay(0.5)
	
	await tween.finished
	number.queue_free()

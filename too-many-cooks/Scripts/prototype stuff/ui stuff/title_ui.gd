extends Control
var can_start_game = false

signal stop_spinning_enivonment

# Called when the node enters the scene tree for the first time.
func _ready():
	title_cinematics_gogogo()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(event):
	if event is InputEventKey and event.pressed and can_start_game:
		can_start_game = false
		cast_aside_title_and_get_to_menu()
		stop_spinning_enivonment.emit()
		
		
func title_cinematics_gogogo():
	var tween = get_tree().create_tween()
	tween.tween_property($titletop/MarginContainer,"theme_override_constants/margin_top",40,1.0).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property($titlebottom/MarginContainer,"theme_override_constants/margin_top",-80,1.0).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	await get_tree().create_timer(2.0).timeout
	can_start_game = true

func cast_aside_title_and_get_to_menu():
	var tween = get_tree().create_tween()
	tween.parallel().tween_property($titletop/MarginContainer,"position",Vector2(-500,0),.5).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property($titlebottom/MarginContainer,"position",Vector2(-1200,0),.3).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)


func _on_quit_button_down():
	get_tree().quit()

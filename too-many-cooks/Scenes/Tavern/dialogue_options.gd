extends Control
@export var dialogue_box_ref : Control

func show_menu():
	await dialogue_box_ref.done_printing
	var tween = get_tree().create_tween()
	tween.tween_property(self,"position",Vector2(self.position.x,174),.5).set_trans(Tween.TRANS_CUBIC)

func hide_menu():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"position",Vector2(self.position.x,-340),.5).set_trans(Tween.TRANS_CUBIC)
	await tween.finished


func _on_dialogue_box_show_question(questions):
	questions = questions.split(",")
	
	show_menu()
	print(questions)
	$PlayerChoiceA.text = questions[0]
	$PlayerChoiceB.text = questions[1]
	$PlayerChoiceC.text = questions[2]

extends Control

#Export data for subtitles, voice lines, and whether this subtitle (index) should turn pages.
#ALL ARRAYS MUST BE THE SAME LENGTH!!!
@export var Subtitles : Array[String]
@export var Voice : Array[AudioStream]
@export var NextPage : Array[bool]

#"System" vars for subtitle advancement and indices.
var can_advance = true
var index : int
var page_index : int = -1

#Var references to scene nodes commonly touched.
var sub_ref : RichTextLabel
var voice_ref : AudioStreamPlayer
var wait_ref : Timer

func _ready():
	Global.First_Time_Combat = true
	Global.First_Time_Tavern = true
	PlayerStats.current_class = PlayerStats.classes.none
	FadeInFadeOut.fade_in()
	sub_ref = $Subtitle
	voice_ref = $Voice
	wait_ref = $Timer
	next_line(0)
	$Music.play()

func _process(_delta):
	var input = Input.is_action_just_pressed("attack") or Input.is_action_just_pressed("dash")
	if input:
		next_line(index + 1)

#Attempt to move to the next subtitle.
func next_line(i: int):
	#Check if input is allowed AND next line exists.
	if can_advance and index < Subtitles.size()-1:
		index = i
		can_advance = false
		
		#Fade subtitle out, wait for fade to complete.
		voice_ref.stop()
		var tween = get_tree().create_tween().set_parallel(true)
		tween.tween_property(sub_ref,"position",Vector2(76,700.0),.5).set_trans(Tween.TRANS_CUBIC)
		tween.tween_property($PageArrow,"position",Vector2(1070,728),.4).set_trans(Tween.TRANS_CUBIC)
		wait_ref.start()
		await wait_ref.timeout
		
		#Set new data, move new page in (if applicable).
		set_data()
		tween_page()
		
		#Fade subtitle back in.
		voice_ref.play()
		tween = get_tree().create_tween()
		tween.tween_property(sub_ref,"position",Vector2(76,575.0),.5).set_trans(Tween.TRANS_CUBIC)
		var arrow_tween = get_tree().create_tween()
		arrow_tween.tween_property($PageArrow,"position",Vector2(1070,584),.4).set_trans(Tween.TRANS_CUBIC)
		await tween.finished
		can_advance = true
	elif can_advance and index >= Subtitles.size()-1:
		go_to_game()

#Update subtitle text and audio player sound.
func set_data() -> void:
	sub_ref.text = Subtitles[index]
	voice_ref.stream = Voice[index]

#Tween the next page in, if we should (bool at NextPage index is true).
func tween_page() -> void:
	if NextPage[index]:
		page_index += 1
		var cur_page = $Pages.get_child(page_index)
		var tween = get_tree().create_tween()
		tween.tween_property(cur_page,"position",Vector2(576,320),1).set_trans(Tween.TRANS_CUBIC)

#Load prologue combat scene, once all Subtitles have completed.
func go_to_game() -> void:
	FadeInFadeOut.fade_out()
	await get_tree().create_timer(1.2).timeout
	var target_scene = ResourceLoader.load("uid://dkpv4bqf7uhxt")
	get_tree().change_scene_to_packed(target_scene)

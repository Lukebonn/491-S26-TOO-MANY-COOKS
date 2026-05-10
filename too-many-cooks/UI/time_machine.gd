extends Timer

var level_time
var seconds
var minutes
@export var timer_reference: Label
@onready var hud_timer : Label = $"../HUD Timer"

func _ready():
	level_time = 0
	seconds = 0
	minutes = 0

func _process(_delta: float) -> void:
	if seconds >= 60:
		seconds = 0
		minutes += 1
	seconds = snapped(seconds, 0.01)
	#if minutes == 0:
		#timer_reference.text = "0:0" + str(seconds)
		#hud_timer.text = "0:0" + str(seconds)
	#else:
	if seconds < 10:
		timer_reference.text = str(minutes) + ":0" + str(seconds)
		hud_timer.text = str(minutes) + ":0" + str(seconds)
	else:
		timer_reference.text = str(minutes) + ":" + str(seconds)
		hud_timer.text = str(minutes) + ":" + str(seconds)
	#print("Level Time " + str(level_time))
	#print("Minutes: " + str(minutes))
	#print("Seconds: " + str(seconds))
	

func _on_timeout() -> void:
	level_time += 0.1
	seconds += 0.1

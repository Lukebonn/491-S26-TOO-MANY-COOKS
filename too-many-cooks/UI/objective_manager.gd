extends Node
@export var time_machine_ref : Timer
signal give_report_data(obj_title, result)

func _ready():
	pick_an_objective()

var level_kill_count : int
var has_not_dashed : bool
var no_damage : bool
var coins_collected : int
var speedrun_under_60 : bool

var objective_task_key : String
var objective_title : String
var objective_result : bool 
signal pause_objective(objective_title)
signal ui_objective(objective_title)
func pick_an_objective():
	match randi_range(2,5):
		1:
			print("Defeat enemies")
			objective_title = "Defeat 15 enemies"
			objective_task_key = "enemies"
		2:
			print("Clear without dashing")
			objective_title = "Clear this level dashless"
			objective_task_key = "dashless"
		3:
			print("Clear without taking damage")
			objective_title = "Clear without taking damage"
			objective_task_key = "nohit"
		4:
			print("Clear collecting 150 gold")
			objective_title = "Collect 150 gold"
			objective_task_key = "rich"
		5:
			print("Clear in under 60 seconds")
			objective_title = "Clear in less than a minute"
			objective_task_key = "speedrun"
	pause_objective.emit(objective_title)
	ui_objective.emit(objective_title)
	
func evaluate_objective():
	match objective_task_key:
		"enemies":
			if PlayerStats.level_kill_count >= 15:
				objective_result = true
		"rich":
			if PlayerStats.Floor_Gold >= 150:
				objective_result = true
		"speedrun":
			if time_machine_ref.level_time < 60:
				objective_result = true
		"dashless":
			if PlayerStats.has_not_dashed == true:
				objective_result = true
		"nohit":
			if PlayerStats.Enemy_Damage_Dealt <= 0:
				objective_result = true

func _on_ui_level_is_complete():
	evaluate_objective()
	give_report_data.emit(objective_title,objective_result)

extends Node
#player stats go here and are referenced by calling PlayerStats.variable_name
#lets also use capital letters for these vars since they public
#also comment the intended use for each variable
#make sure they are typed variables too, most will be floats

#temp resource to track currency for tavern upgrades, will likely be changed. collected from enemies for now
var Gold := 0

#speed stats for the player
var Max_Speed = 200.0
var Speed_Slowdown = 150.0

extends Node3D
@export var CatSpot = Marker3D
#this script exists to prevent a lag spike when tweening to the menu part 



func _on_title_ui_stop_spinning_enivonment():
	position = CatSpot.position

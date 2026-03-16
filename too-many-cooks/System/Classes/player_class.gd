extends Resource
class_name PlayerClass

##holds the scripts for the state machine
@export var attack : Script
@export var dash : Script
@export var magic : Script

##stat modifiers for the class
@export var str_mod : float
@export var def_mod : float
@export var spd_mod : float
@export var mag_mod :float

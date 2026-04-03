extends Node2D

@onready var weather_manager = $WeatherManager

func _ready():
	weather_manager.change_to_list([HeavyRain,HeavyWind,Fog])

extends Sprite2D

@export var shown_alpha: float = 0.45
@export var fade_speed: float = 8.0

var target_alpha: float = 0.0

func _ready():
	visible = true
	modulate.a = 0.0

func _process(delta):
	modulate.a = lerp(modulate.a, target_alpha, fade_speed * delta)

func show_warning():
	target_alpha = shown_alpha

func hide_warning():
	target_alpha = 0.0

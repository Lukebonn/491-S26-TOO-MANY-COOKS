extends ProgressBar
#Drag and drop to enemies

var parent_ref 

# Called when the node enters the scene tree for the first time.
func _ready():
	if get_parent().has_method("change_state"):
		parent_ref = get_parent()
		max_value = parent_ref.health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	value = parent_ref.current_health

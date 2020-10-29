extends Control

var progressbar
export var animated_val : float

func _ready():
#	var bgfix = get_tree().get_root().get_node("bgfix")
#	bgfix.fix_background_scale($loadbg, 1, 1)
	progressbar = get_node("loadbg/CenterContainer/VBoxContainer/progressbar")
	
func _process(delta):
	progressbar.set_value(animated_val)



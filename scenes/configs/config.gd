extends Node
export (String) var page_title


func _ready():
	OS.set_window_title(page_title)
#	OS.set_window_fullscreen(false)
#	OS.set_window_size(Vector2(1080,1830))
	OS.set_min_window_size(Vector2(1080,1830))
#	OS.set_window_per_pixel_transparency_enabled(true)


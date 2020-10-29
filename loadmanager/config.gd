extends Node

onready var loadmanager = get_tree().get_root().get_node("Loadmanager")
onready var config_path = "res://loadmanager/config.conf"
var config_file

onready var varCount	 = 3
onready var resolutionID = 0
onready var vSync		 = 0
onready var displayMode	 = 0

onready var resolutions  = ["1920x1080", "1600x900", "1360x768", "1280x720"]
onready var viewport	 = get_tree().get_root().get_viewport()

func _ready():
	config_file = ConfigFile.new()
	var err = config_file.load(config_path)
	if(err != OK):
		err = create_config()
	if(err != OK):
		loadmanager.show_error("while creating config file" + err as String)
		
func get_resolution(truth) -> Vector2:
	if(truth):
		var string = resolutions[resolutionID]
		var stringArr = string.rsplit("x", 1, 2)
		var width = stringArr[0] as int
		var height = stringArr[1] as int
		return Vector2(width, height)
	else:
		return Vector2(1280,720)

func create_config() -> int:
	config_file.set_value("Display", "resolutionID", resolutionID)
	config_file.set_value("Display", "vSync", vSync)
	config_file.set_value("Display", "displayMode", displayMode)
	return config_file.save(config_path)

func load_config() -> Array:
	var arr = Array()
	resolutionID 	= config_file.get_value("Display", "resolutionID", null)
	vSync 			= config_file.get_value("Display", "vSync", null)
	displayMode 	= config_file.get_value("Display", "displayMode", null)
	arr.append(resolutionID)
	arr.append(vSync)
	arr.append(displayMode)
	return arr
	
func save_config(arr : Array) -> int:
	var tmp = 0
	var err = 0
	var names = ["resolutionID", "vSync", "displayMode"]
	resolutionID = arr[0]
	vSync 		 = arr[1]
	displayMode  = arr[2]
	while(tmp != varCount):
		config_file.set_value("Display", names[tmp], arr[tmp])
		tmp += 1
	err = config_file.save(config_path)
	if (err != OK):
		loadmanager.show_error("while saving config file" + err as String)
	return err
	
func apply_config():
	var res = get_resolution(true)
	
	if(displayMode):
		OS.set_window_fullscreen(true)
		viewport.set_size(res) #WORKS ONLY IN FULLSCREEN 
	else:
		OS.set_window_fullscreen(false)
		OS.set_window_size(res)
	
	if(vSync):
		OS.set_use_vsync(true)
	else:
		OS.set_use_vsync(false)

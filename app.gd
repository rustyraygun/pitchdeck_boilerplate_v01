extends Node

onready var loadmanager = get_tree().get_root().get_node("Loadmanager")
onready var Config		= get_tree().get_root().get_node("config")
#onready var Config		= load("res://loadmanager/config.gd")


func _ready():
	#load config file and load manager	
	Config.load_config()
	Config.apply_config()
	loadmanager.goto_scene("res://loadmanager/MenuUI.tscn", null, false)

	
	

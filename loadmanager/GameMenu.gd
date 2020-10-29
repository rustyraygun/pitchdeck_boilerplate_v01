extends CenterContainer

onready var BResume 	= $VBoxContainer/BResume
onready var BSettings	= $VBoxContainer/BSettings
onready var BMenu		= $VBoxContainer/BMenu
onready var BExit		= $VBoxContainer/BExit
onready var timer 		= $startProcessing
onready var loadmanager = get_tree().get_root().get_node("Loadmanager")
onready var settingsOpen = false

func _ready():
	set_process(false)
	BResume.connect("pressed", self, "resume")
	BSettings.connect("pressed", self, "open_settings")
	BMenu.connect("pressed", self, "goMenu")
	BExit.connect("pressed", self, "exitGame")
	timer.connect("timeout", self, "start")

func start():
	set_process(true)

func _process(delta):
	if (Input.is_key_pressed(KEY_ESCAPE) and !settingsOpen):
		get_tree().paused = false
		queue_free()
	
func resume():
	get_tree().paused = false
	queue_free()
	
func open_settings():
	var pos = Vector2(125, 500)
#	var pos = get_tree().get_root().get_node("MainScn").get_node("Game").get_node("Player").get_position()
	var panel = loadmanager.add_scene("res://SettingsPanel.tscn")
	panel.set_position(Vector2(pos.x - (panel.get_size().x/2), panel.get_position().y))
#	panel.set_position(Vector2(12, 233))
	panel.connect("Closing", self, "onSettingsClosing")
	settingsOpen = true

func onSettingsClosing():
	settingsOpen = false

func goMenu():
	get_tree().paused = false
	loadmanager.goto_scene("res://MenuUI.tscn", null, true)
	
func exitGame():
	get_tree().quit() #TODO QUIT HANDLING, SAVING SCENE

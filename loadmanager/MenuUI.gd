extends Node

export (PackedScene) var SettingsPanel

onready var loadmanager = get_tree().get_root().get_node("Loadmanager")
#onready var bgfix  		= get_tree().get_root().get_node("bgfix")

#___main_nav_buttons___
onready var button_one	= $Center/main_nav_panel/VBoxContainer/one/About_The_Game
onready var button_two	= $Center/main_nav_panel/VBoxContainer/two/Gameplay
onready var button_three	= $Center/main_nav_panel/VBoxContainer/three/Development
onready var button_four	= $Center/main_nav_panel/VBoxContainer/four/Extras
onready var levelLabel  = $CenterBottom/VBoxContainer/Label

#__main_scenes_nav___
export (String, FILE, "*.tscn") var scene_1 
export (String, FILE, "*.tscn") var scene_2
export (String, FILE, "*.tscn") var scene_3
export (String, FILE, "*.tscn") var scene_4
export (String, FILE, "*.tscn") var scene_5
onready var levelSelected = "Gameplay"

#__game_details
export(String) var game_title

func _ready():
	$CenterBottom/VBoxContainer/B_Play.connect("pressed", self, "playgame")
	$CenterBottom/VBoxContainer/B_Settings.connect("pressed", self, "open_settings")
	$CenterBottom/VBoxContainer/B_Exit.connect("pressed", self, "closeGame")
	
	#___set game title___
	$CenterTop/GameTitle.set_text(game_title)
	

#	levelTwo.connect("mouse_entered", self, "hoverOn", [levelTwo])
#	levelOne.connect("mouse_exited", self, "hoverOff", [levelOne])
	
	#___Main_Navigation
	button_one.connect("pressed", self, "selectLevel", [button_one])
	button_two.connect("pressed", self, "selectLevel", [button_two])
	button_three.connect("pressed", self, "selectLevel", [button_three])
	button_four.connect("pressed", self, "selectLevel", [button_four])
#	levelSelected = "B_LevelOne"
	
func playgame() -> void:
	if(levelSelected == "Gameplay"):
		loadmanager.goto_scene(scene_2, null, true)
		
	if(levelSelected == "About_The_Game"):
		loadmanager.goto_scene(scene_1, null, true)
		
	if(levelSelected == "Development"):
		loadmanager.goto_scene(scene_3, null, true)
		
	if(levelSelected == "Extras"):
		loadmanager.goto_scene(scene_4, null, true)
#	else:
#		loadmanager.goto_scene(scene_1, null, true)
		
func closeGame():
	get_tree().quit()

func open_settings() -> void:
	var panel = SettingsPanel.instance()
	add_child(panel)
	
func selectLevel(button):
	levelSelected = button.get_name()
	levelLabel.set_text("You're about to view: " + levelSelected)

func hoverOn(button):
	var label = button.get_parent().get_node("label")
	var font = label.get_theme().default_font
	var curScale = label.get_scale()
	font.outline_size = 1
	label.set_scale(Vector2(curScale.x + 0.3, curScale.y + 0.3))

func hoverOff(button):
	var label = button.get_parent().get_node("label")
	var font = label.get_theme().default_font
	var curScale = label.get_scale()
	font.outline_size = 0
	label.set_scale(Vector2(curScale.x - 0.3, curScale.y - 0.3))


func _on_VScrollBar_scrolling():
	pass


#func _on_VSlider_value_changed(value):
#	$Center/main_nav_panel.scroll_vertical = value


#func _on_one_pressed():
#	loadmanager.goto_scene("res://scenes/page_template.tscn", null, true)


	


func _on_About_The_Game_mouse_entered():
	$Center/main_nav_panel/VBoxContainer/one/About_The_Game/CPUParticles2D.set_emitting(true)


func _on_About_The_Game_mouse_exited():
	$Center/main_nav_panel/VBoxContainer/one/About_The_Game/CPUParticles2D.set_emitting(false)

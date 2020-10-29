extends MenuButton
onready var menu 
var menu_selected = 0
onready var loadmanager = get_tree().get_root().get_node("Loadmanager")


func _ready():
	menu = get_popup()
	menu.add_item("About The Game")
	menu.add_item("Game Play")
	menu.add_item("Development")
	menu.add_item("Extras")
	menu.add_item("Back To Main Menu")
	menu.connect("id_pressed", self, "item_selected")

	
func item_selected(ID):
	if menu.get_item_text(ID) == "About The Game":
		loadmanager.goto_scene("res://scenes/about_the_game.tscn", null, true)
		
	if menu.get_item_text(ID) == "Game Play":
		loadmanager.goto_scene("res://scenes/game_play.tscn", null, true)
		
	if menu.get_item_text(ID) == "Development":
		loadmanager.goto_scene("res://scenes/development.tscn", null, true)
		
	if menu.get_item_text(ID) == "Extras":
		loadmanager.goto_scene("res://scenes/extras.tscn", null, true)
		
	if menu.get_item_text(ID) == "Back To Main Menu":
	
		loadmanager.goto_scene("res://loadmanager/MenuUI.tscn", null, true)
		
		
#	print(menu.get_item_text(ID), " pressed")
#	menu.get_item_text(ID), " pressed"

#	if id == 2:
#		print("about the game pressed")
#	windowedCB.connect("toggled", self, "toggle_display_mode", [windowedCB])
	



func _on_options_menu_pressed():
	pass

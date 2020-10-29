extends Control

onready var Config		= get_tree().get_root().get_node("config")
onready var opz 		= $panel/OpzRes
onready var fullscrCB 	= $panel/L_Fullscreen/CheckBox
onready var windowedCB 	= $panel/L_Windowed/CheckBox
onready var vSyncCB		= $panel/L_Vsync/CheckBox
#TO SAVE---------
var resolutionID
var vSync
var displayMode
#----------------
signal Closing

func _ready():
#	initOpz()
	init_status()
	#BUTTONS
	$panel/B_Exit.connect("pressed", self, "closePanel")
	$panel/B_Apply.connect("pressed", self, "save_and_apply")
	#CHECKBOXES
	fullscrCB.connect("toggled", self, "toggle_display_mode", [fullscrCB])
	windowedCB.connect("toggled", self, "toggle_display_mode", [windowedCB])
	vSyncCB.connect("toggled", self, "toggle_vsync")
	#RESOLUTION SELECTOR
	opz.connect("item_selected", self, "onSelected")

#func initOpz() -> void:
#	var vectors = Config.resolutions
#	var itemCount = vectors.size()
#	var count = 0
#
#	while(count != itemCount):
#		opz.add_item(vectors[count], count)
#		count += 1

func init_status():
	#RETRIVE FROM FILE
	var arr = Config.load_config()
	resolutionID = arr[0]
	vSync		 = arr[1]
	displayMode	 = arr[2]
	
	opz.selected = resolutionID
	
	if (displayMode):
		fullscrCB.pressed = true
	else:
		windowedCB.pressed = true
		
	if (vSync):
		vSyncCB.pressed = true
	
func save_and_apply() -> void:
	#SAVE TO FILE
	var arr = [resolutionID, vSync, displayMode]
	Config.save_config(arr)
	#APPLY
	Config.apply_config()

func closePanel() -> void:
	emit_signal("Closing")
	queue_free()

func toggle_vsync(toggle):
	if (vSyncCB.pressed):
		vSync = true
	else:
		vSync = false

func toggle_display_mode(toggle, CB):
	var bro 
	if (CB.get_parent().get_name() == "L_Fullscreen"):
		bro = windowedCB
	else:
		bro = fullscrCB
		
	if(CB.pressed): 				#IF CB IS CHECKED
		bro.pressed = false
		if (bro == fullscrCB): 	#IF CB IS WINDOWED
			displayMode = false
		else:					#IF CB IS FULLSCREEN
			displayMode = true
	else:	 					#IF CB IS UNCHECKED
		bro.pressed = true
		if (bro == fullscrCB):	#IF CB IS WINDOWED
			displayMode = true
		else:					#IF CB IS FULLSCREEN
			displayMode = false

func onSelected(ID) -> void:
	resolutionID = ID

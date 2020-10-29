extends Node

var root
var mainscn
var scenes
var loader
var loadscreen
var animated_val
var processtimer
var delay_load_timer
var label
var tween
var progressbar
onready var time_max = 1000 #msec

func _ready():
	root = get_tree().get_root()
	mainscn = root.get_node("app")
	set_process_internal(true)
	set_process(false)

func show_error(err : String) -> void:
	var errDiag = root.get_node("errDiag")
	if(errDiag == null):
		errDiag = ConfirmationDialog.new()
		errDiag.set_name("errDiag")
		errDiag.set_title("Runtime Error!")
		root.add_child(errDiag)
	
	errDiag.set_text("Error Code: " + err)
	errDiag.popup_centered(errDiag.get_minimum_size())
	
func getActiveScenes() -> Array:
	scenes = mainscn.get_children()
	return scenes
	
func free_scene(name : String):
	return call_deferred("def_free_scene", name)
	
func goto_scene(path : String, scenes_to_destroy, freeAll : bool): #remvoe all other scenes
	return call_deferred("def_goto_scene", path, scenes_to_destroy, freeAll)

func add_scene(path : String):
	var tmp = ResourceLoader.exists(path)
	var scene
	if( tmp ):
		var rl = ResourceLoader.load(path)
		scene = rl.instance()
		mainscn.add_child(scene)
	else:
		show_error("ResourceLoader.exists(" + path as String + ")" + " returned: " + tmp as String)
		return false
	return scene
	
func def_free_scene(name : String) -> bool:
	getActiveScenes()
	var count = scenes.size()
	var found = false
	
	while (count != 0):
		if(scenes[count].get_name() == name):
			found = true
			break;
		count -= 1
	if(!found):
		show_error("def_free_scene(name : String), could not find the scene (" + name + ") to free")
		return false
		
	scenes[count].queue_free()
	return true

func def_goto_scene(path : String, scenes_to_destroy, freeAll : bool) -> void:
	
	#FREE SCENES
	if (!freeAll and scenes_to_destroy != null):
		var count = scenes_to_destroy.size()
		while (count != 0):
			scenes_to_destroy[count-1].queue_free()
			count -=1
	elif (freeAll):
		var count = getActiveScenes().size()
		while (count != 0):
			scenes[count-1].queue_free()
			count -=1
	
	loader = ResourceLoader.load_interactive(path)
	if loader == null: # check for errors
		show_error("ResourceLoader.load_interactive(" + path as String + ")")
		return
		
	loadscreen = ResourceLoader.load("res://loadmanager/LoadingScn.tscn")
	loadscreen = loadscreen.instance()
	mainscn.add_child(loadscreen)
	
	label = root.get_node("app/LoadingScn/loadbg/CenterContainer/VBoxContainer/LoadLabel")
	tween = root.get_node("app/LoadingScn/loadbg/CenterContainer/VBoxContainer/tween")
	progressbar = root.get_node("app/LoadingScn/loadbg/CenterContainer/VBoxContainer/progressbar")
	processtimer = root.get_node("app/LoadingScn/Timer")
	delay_load_timer = root.get_node("app/LoadingScn/delay_load_timer")
	processtimer.connect("timeout", self, "_processing")
#	delay_load_timer.connect("timeout", self, "_delay_timer")
	
	#set_process(true)
#func _delay_timer():
#	processtimer.start()
	
func _processing() -> void:
	var err
	var resource
	
	if(loader == null):
		show_error("while pooling resource")
		return
	
	#while(OS.get_ticks_msec() < (t + time_max)):
	err = loader.poll()
	if(err == ERR_FILE_EOF):
		resource = loader.get_resource()
		resource = resource.instance()
		mainscn.add_child(resource)
		loader = null
		loadscreen.queue_free()
		return
	elif(err == OK):
		update_progress()
		return
	else:
		loader = null
		show_error("while pooling resource")
		return 

func update_progress() -> void:
	var progress = float(loader.get_stage()) / loader.get_stage_count()
	
	label.set_text("Loading.. " + loader.get_stage() as String + " / " + loader.get_stage_count() as String)
	
	tween.interpolate_property( loadscreen, 'animated_val',
								progressbar.get_value(), (progress*100),
								0.4, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	if (!tween.is_active()):
		tween.start()

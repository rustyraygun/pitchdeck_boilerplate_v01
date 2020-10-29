extends Panel

onready var loadmanager = get_tree().get_root().get_node("Loadmanager")
onready var current_page = get_node("/root/app/page").page_title
onready var controller = $HSplitContainer/Panel2/MarginContainer/RichTextLabel/AnimationPlayer
onready var text_box = get_node("HSplitContainer/Panel2/MarginContainer/RichTextLabel")
var current_txt
var new_txt
var content
export (String) var txt_content_1
export (String) var txt_content_2
export (String) var txt_content_3
export (String) var txt_content_4
#___sub images___
export (String) var sub_image_1
export (String) var banner_sub_image_1
export (String) var sub_image_2
export (String) var banner_sub_image_2
export (String) var sub_image_3
export (String) var banner_sub_image_3
#___
onready var set_text_anim = get_node("HSplitContainer/Panel2/MarginContainer/RichTextLabel/set_text")
onready var banner_image = get_node("/root/app/page/CenterContainer/VBoxContainer/img_banner")


#___text_files___
#about
onready var file_1 = 'res://assets/text_files/about_foundation.txt'
onready var file_2 = 'res://assets/text_files/about_genres.txt'
onready var file_3 = 'res://assets/text_files/about_story.txt'
onready var file_4 = 'res://assets/text_files/about_characters.txt'
#gameplay
onready var file_1b = 'res://assets/text_files/gameplay_type.txt'
onready var file_2b = 'res://assets/text_files/gameplay_play.txt'
onready var file_3b = 'res://assets/text_files/gameplay_controls.txt'
#development
onready var file_1c = 'res://assets/text_files/development_platforms.txt'
onready var file_2c = 'res://assets/text_files/development_genres.txt'
onready var file_3c = 'res://assets/text_files/development_price.txt'
onready var file_4c = 'res://assets/text_files/development_schedule.txt'
onready var file_5c = 'res://assets/text_files/development_swot.txt'
#extras
onready var file_1d = 'res://assets/text_files/extras_about.txt'
onready var file_2d = 'res://assets/text_files/extras_statement.txt'
onready var file_3d = 'res://assets/text_files/extras_moleskin.txt'


func _ready():
	print(current_page)
#	set_text_anim.play("text_1")


#___load the page relevant - first file___
	if current_page == "About The Game":
		load_file(File, file_1)
		text_box.set_text(content)
		set_text_anim.play("show_text")
		
	if current_page == "Gameplay":
		load_file(File, file_1b)
		text_box.set_text(content)
		set_text_anim.play("show_text")
		
	if current_page == "Development":
		load_file(File, file_1c)
		text_box.set_text(content)
		set_text_anim.play("show_text")
		
	if current_page == "Extras":
		load_file(File, file_1d)
		text_box.set_text(content)
		set_text_anim.play("show_text")
		
		
	#__set text size animation and slider setup ___
	$HSplitContainer/Panel2/MarginContainer/RichTextLabel/AnimationPlayer.play("text_size", -1, 0, false)
	$HSplitContainer/Panel2/MarginContainer/RichTextLabel/AnimationPlayer.set_current_animation("text_size")

#	controller.seek(0, true)
#	yield(get_tree().create_timer(6), "timeout")
	
	

	
func _process(delta):
	$HSplitContainer/Panel2/MarginContainer/sub_image.rect_position = Vector2(0, 150)
	
	
func load_first_file():
	load_file(File, file_1)
	text_box.set_text(content)
	
	

func _on_VSlider_value_changed(value):
	var controller = $HSplitContainer/Panel2/MarginContainer/RichTextLabel/AnimationPlayer
#	controller.play("text_size", -1, 0, false)

#	controller.seek(0, true)
	
	controller.seek(value,  true)
	
	



func _on_section_btn_1_pressed():	
	if current_page == "About The Game":
		load_file(File, file_1)
		text_box.set_text(content)
		set_text_anim.play("show_text")
		
	if current_page == "Gameplay":
		load_file(File, file_1b)
		text_box.set_text(content)
		set_text_anim.play("show_text")
		
	if current_page == "Development":
		load_file(File, file_1c)
		text_box.set_text(content)
		set_text_anim.play("show_text")
		
	if current_page == "Extras":
		load_file(File, file_1d)
		text_box.set_text(content)
		set_text_anim.play("show_text")
		
#	set_text_anim.play("text_1")
	$HSplitContainer/Panel2/MarginContainer/sub_image.hide()


func _on_section_btn_2_pressed():
	if current_page == "About The Game":
		load_file(File, file_2)
		text_box.set_text(content)
		set_text_anim.play("show_text")
		
	if current_page == "Gameplay":
		load_file(File, file_2b)
		text_box.set_text(content)
		set_text_anim.play("show_text")
		
	if current_page == "Development":
		load_file(File, file_2c)
		text_box.set_text(content)
		set_text_anim.play("show_text")
		
	if current_page == "Extras":
		load_file(File, file_2d)
		text_box.set_text(content)
		set_text_anim.play("show_text")
	$HSplitContainer/Panel2/MarginContainer/sub_image.hide()


func _on_section_btn_3_pressed():
	if current_page == "About The Game":
		load_file(File, file_3)
		text_box.set_text(content)
		set_text_anim.play("show_text")
		$HSplitContainer/Panel2/MarginContainer/sub_image.hide()
		
	if current_page == "Gameplay":
		load_file(File, file_3b)
		text_box.set_text(content)
		set_text_anim.play("show_text")
		$HSplitContainer/Panel2/MarginContainer/sub_image.hide()
		
	if current_page == "Development":
		load_file(File, file_3c)
		text_box.set_text(content)
		set_text_anim.play("show_text")
		$HSplitContainer/Panel2/MarginContainer/sub_image.hide()
		
	if current_page == "Extras":
		load_file(File, file_3d)
		text_box.set_text(content)
		set_text_anim.play("show_text")
		$HSplitContainer/Panel2/MarginContainer/sub_image.show()
		$HSplitContainer/Panel2/MarginContainer/sub_image.set_texture(load(sub_image_3))
		banner_image.set_texture(load(banner_sub_image_3))
	


func _on_section_btn_4_pressed():
	if current_page == "About The Game":
		load_file(File, file_4)
		text_box.set_text(content)
		set_text_anim.play("show_text")
		$HSplitContainer/Panel2/MarginContainer/sub_image.show()
		$HSplitContainer/Panel2/MarginContainer/sub_image.set_texture(load(sub_image_1))
		banner_image.set_texture(load(banner_sub_image_1))
		
	if current_page == "Development":
		load_file(File, file_4c)
		text_box.set_text(content)
		set_text_anim.play("show_text")
		$HSplitContainer/Panel2/MarginContainer/sub_image.show()
		$HSplitContainer/Panel2/MarginContainer/sub_image.set_texture(load(sub_image_2))
		banner_image.set_texture(load(banner_sub_image_2))
		
	if current_page == "Extras":
		loadmanager.goto_scene("res://scenes/updates.tscn", null, false)
		


func _on_section_btn_5_pressed():
	if current_page == "Development":
		load_file(File, file_5c)
		text_box.set_text(content)
		set_text_anim.play("show_text")
	$HSplitContainer/Panel2/MarginContainer/sub_image.hide()
	
func _on_section_btn_6_pressed():
	pass # Replace with function body.
	
	
	
	
#___file loader___
func load_file(File, file):

	var f = File.new()
	f.open(file, File.READ)
	var index = 1
	while not f.eof_reached(): # iterate through all lines until the end of file is reached
		var line = f.get_line()
		line += " "
		current_txt = str(line + str(index))
#		print(line + str(index))
		content = format_text("body", current_txt)
#		print(format_text("body", current_txt))
		

		index += 1
	f.close()
	return
	
func format_text(tag, default =""):
	var regex = RegEx.new()
	regex.compile("<" + tag + ">(.|\n)*?</" + tag + ">")
	var result = regex.search(current_txt)
	if result:
		return result.get_string().replace("<"+ "body"+ ">", "").replace("</"+ "body"+ ">", "").replace("<"+ "br"+ ">", "\n").replace("</"+ "h1"+ ">", "").replace("<"+ "p"+ ">", "").replace("</"+ "p"+ ">", "")
	return default




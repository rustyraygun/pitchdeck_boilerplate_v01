extends Node
export (String) var img1 
export (String) var img2 
export (String) var img3
export (String) var page_title 
export (String) var build_link
export (String) var sketchbook_link
export (String) var website_link


onready var page_title_label = get_node("CenterContainer/VBoxContainer/header/Label")
 

func _ready():
	page_title_label.set_text(page_title)
	$CenterContainer/VBoxContainer/img_banner.set_texture(load(img1))
	

func _on_img1_pressed():
	$CenterContainer/VBoxContainer/img_banner.set_texture(load(img1))


func _on_img2_pressed():
	$CenterContainer/VBoxContainer/img_banner.set_texture(load(img2))


func _on_img3_pressed():
	$CenterContainer/VBoxContainer/img_banner.set_texture(load(img3))


func _on_downloads_pressed():
	OS.shell_open(build_link) 


func _on_sketchbook_pressed():
	OS.shell_open(sketchbook_link) 


func _on_website_pressed():
	OS.shell_open(website_link)

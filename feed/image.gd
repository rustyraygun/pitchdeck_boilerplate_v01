extends Control
var img_num = 2

func _ready():
	# Create an HTTP request node and connect its completion signal.
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", self, "_http_request_completed")
	
	# Perform the HTTP request. The URL below returns a PNG image as of writing.
	var error = http_request.request("http://127.0.0.1:5500/images/img_" + str(img_num) + ".png")
	if error != OK:
		push_error("An error occurred in the HTTP request.")
		img_num = 1

func update_request():
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", self, "_http_request_completed")
	
	# Perform the HTTP request. The URL below returns a PNG image as of writing.
	var error = http_request.request("http://127.0.0.1:5500/images/img_" + str(img_num) + ".png")
	if error != OK:
		push_error("An error occurred in the HTTP request.")
		img_num = 1
	

# Called when the HTTP request is completed.
func _http_request_completed(result, response_code, headers, body):
	var image = Image.new()
	var error = image.load_png_from_buffer(body)
	if error != OK:
		push_error("Couldn't load the image.")

	var texture = ImageTexture.new()
	texture.create_from_image(image)

	# Display the image in a TextureRect node.
	var texture_rect = get_node("../current_img")
	
	
	texture_rect.texture = texture


func _on_Button_pressed():
	img_num -= 1
	update_request()


func _on_RichTextLabel_focus_entered():
	img_num = 1
	update_request()
#	var scroll_bar = get_node("../RichTextLabel").get_v_scroll()
#	print(scroll_bar.step - 0.5)
#	if scroll_bar.step > 0.9:
#		print("okkkkk!")
	



func _on_RichTextLabel_focus_exited():
	img_num = 2
	update_request()


func _on_RichTextLabel_mouse_entered():
	img_num = 1
	update_request()


func _on_RichTextLabel_mouse_exited():
	img_num = 2
	update_request()


func _on_current_img_mouse_entered():
	pass # Replace with function body.


func _on_current_img_mouse_exited():
	pass # Replace with function body.

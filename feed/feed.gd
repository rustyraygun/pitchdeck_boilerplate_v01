extends Control
# most recent updates /feed template
onready var texture_url = get_node("TextureRectUrl")


func _ready():
	_make_request()

#	$HTTPRequest.connect("request_completed", self, "_on_request_completed")

func _make_request():

	$HTTPRequest.request("https://little-cooperative-chair.glitch.me/posts/1")
	#set main banner / background image
	texture_url._setTextureUrl("https://rustyraygun.github.io/images/escapefactory9.jpg")
	


func _on_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	print(json.result)
	
	
	

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var html = body.get_string_from_utf8()
#	$RichTextLabel.text = innerHTML("body", html)
	$RichTextLabel.text = innerHTML("article", html)
	OS.set_window_title(innerHTML("title", html))
	


	
	
func innerHTML(tag, html, default =""):
	var regex = RegEx.new()
	regex.compile("<" + tag + ">(.|\n)*?</" + tag + ">")
	var result = regex.search(html)
	if result:
		return result.get_string().replace("<"+ "body"+ ">", "").replace("</"+ "body"+ ">", "").replace("<"+ "h1"+ ">", "").replace("</"+ "h1"+ ">", "").replace("<"+ "p"+ ">", "").replace("</"+ "p"+ ">", "")
	return default


func _on_Timer_timeout():
	_make_request()
	


func _on_Button2_pressed():
	self.hide()

extends Panel

@export var characterPath: String
@export var characterTexture: CompressedTexture2D

func _ready():
	$TextureRect.texture = characterTexture
	
func set_selected(boolean):
	var stylebox = get_theme_stylebox("panel").duplicate()
	
	if boolean:
		stylebox.border_color = Color(0.2235, 0.4314, 0.9529)
	else:
		stylebox.border_color = Color(0.32, 0.55, 0.78)
		
	add_theme_stylebox_override("panel", stylebox)
	
	

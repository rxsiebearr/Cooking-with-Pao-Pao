extends Panel

@export var characterPath: String
@export var characterTexture: CompressedTexture2D

func _ready():
	$TextureRect.texture = characterTexture
	
func set_selected(boolean):
	var stylebox = get_theme_stylebox("panel").duplicate()
	
	if boolean:
		stylebox.border_color = Color(0.2235, 0.4314, 0.9529)
		stylebox.expand_margin_left = 4.0
		stylebox.expand_margin_top  = 4.0
		stylebox.expand_margin_right = 4.0
		stylebox.expand_margin_bottom = 4.0
	else:
		stylebox.border_color = Color(0.32, 0.55, 0.78)
		stylebox.expand_margin_left = 0.0
		stylebox.expand_margin_top  = 0.0
		stylebox.expand_margin_right = 0.0
		stylebox.expand_margin_bottom = 0.0
		
	add_theme_stylebox_override("panel", stylebox)
	
	

extends Area2D
class_name pickable_item

@export var item_texture: Texture
@onready var sprite_2d: Sprite2D = $Sprite2D
@export var item_name: String = "Unknown"

func _ready() -> void:
	sprite_2d.texture = item_texture

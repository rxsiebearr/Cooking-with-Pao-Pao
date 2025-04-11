extends Area2D
class_name pickable_item

@export var item_texture: Texture
@export var file: Area2D
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	sprite_2d.texture = item_texture

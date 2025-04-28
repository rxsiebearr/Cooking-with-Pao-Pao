extends Area2D
class_name pickable_item

@export var item_texture: Texture
@export var item_name: String = "Unknown"
@export var item_scale: Vector2 = Vector2(0.5, 0.5)

@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	sprite_2d.texture = item_texture
	self.scale = item_scale

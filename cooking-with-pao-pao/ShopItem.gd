extends Control

@export var data: ItemData
@onready var _Texture: TextureRect = $VBoxContainer/TextureRect
@onready var Price: Label = $VBoxContainer/Price
@onready var Name: Label = $VBoxContainer/ItemName

func _ready():
	if data:
		_Texture.texture = data.icon
		Name.text = data.item_name
		Price.text = str(data.price)

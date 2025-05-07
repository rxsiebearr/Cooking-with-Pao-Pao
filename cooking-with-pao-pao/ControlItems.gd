extends Control

@onready var item_scene = preload("res://ShopItem.tscn")
@onready var items_grid = $"Panel/Shop Items"
@onready var Rice_Sell: Button = $VBoxContainer/Sell
@onready var Rice_Seed_Sell: Button = $VBoxContainer/Sell2
@onready var Rice_Buy: Button = $VBoxContainer/Buy
@onready var Rice_Seed_Buy: Button = $VBoxContainer/Buy2
@onready var label: Label = $Panel/TextureRect/Label

var item_paths = [
	"res://Rice Shop Item.tres",
	"res://Rice Seed.tres"
]

func _ready():
	Update_Shop()
	
func Update_Shop():
	for child in items_grid.get_children():
		child.queue_free()
	for path in item_paths:
		var item_data = load(path)
		if item_data:
			var item_instance = item_scene.instantiate()
			item_instance.data = item_data
			items_grid.add_child(item_instance)
			
	label.text = "x" + str(Global.money)

func _On_Rice_Buy_Pressed() -> void:
	Global.money -= 3
	print("Bought")

func _on_Riec_sell_pressed() -> void:
	Global.money += 3
	print("Bought")

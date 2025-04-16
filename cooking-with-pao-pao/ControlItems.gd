extends Control

@onready var item_scene = preload("res://ShopItem.tscn")
@onready var items_grid = $"Panel/Shop Items"

var item_paths = [
	"res://Rice.tres",
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

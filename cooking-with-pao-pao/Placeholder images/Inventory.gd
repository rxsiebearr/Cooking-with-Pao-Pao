extends Control
var current_scene 
@onready var Hotbar: HBoxContainer = $UI/Hotbar
@onready var Grid: GridContainer = $UI/GridContainer

func _on_hotbar_equip(item):
	if current_scene != null:
		current_scene.currently_equipped = item
		
func use_stackable_item():
	Hotbar.update()
	Hotbar.use_current()

func add_item(item : Item1, amount :int = 1):
	for slot in Hotbar.get_children():
		if slot.item == null:
			slot.item = item
			slot.set_amount(amount)
			return
		elif slot.item == item:
			slot.add_amount(2)
			return
	
	for slot in Grid.get_children():
		if slot.item == null:
			slot.item = item
			slot.set_amount(amount)
		elif slot.item == item:
			slot.add_amount(2)
			return
			
	print("Full Inventory")

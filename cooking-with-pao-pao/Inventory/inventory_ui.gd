extends Control
@onready var inventory = preload("res://Inventory/PlayerInventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
var Open = false

func _ready():
	update_slots()
	close()
	
func update_slots():
	for i in range(min(inventory.items.size(), slots.size())):
		slots[i].update(inventory.items[i])
func _process(delta):
	if Input.is_action_just_pressed("Inventory"):
		if Open:
			close()
		else:
			open()
func open():
	self.visible = true
	Open = true
	
func close():
	visible = false
	Open = false

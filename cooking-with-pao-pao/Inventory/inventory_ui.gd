extends Control
@onready var inventory = preload("res://Inventory/PlayerInventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
var Open = false

func _ready():
	close()
	
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

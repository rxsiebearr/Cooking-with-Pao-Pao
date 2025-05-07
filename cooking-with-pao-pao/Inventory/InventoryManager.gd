extends Node
@onready var inventory: CanvasLayer = $UI
var inventory_panel : Control = null 
var is_inventory_open = true

func toggle_inventory():
	if inventory:
		is_inventory_open = !is_inventory_open
		inventory.visible = is_inventory_open

func open_inventory():
	if inventory:
		is_inventory_open = true
		inventory.visible = true

func close_inventory():
	if inventory:
		is_inventory_open = false
		inventory.visible = false
		
	

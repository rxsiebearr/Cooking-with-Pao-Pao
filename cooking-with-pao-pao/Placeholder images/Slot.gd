extends Panel
@export var item: Item1 = null:
	set(value):
		item = value
		
		if value == null:
			$Icon.texture =null
			$Amount.text = ""
			return
		
		$Icon.texture = value.icon

@export var amount : int = 0:
	set(value):
		amount = value
		$Amount.text = str(value)
		if amount <= 0:
			item = null
			
func set_amount(value: int):
	amount = value

func add_amount(value: int):
	amount += value

func _can_drop_data(at_position, data):
	if "Item" in data:
		return is_instance_of(data.item, Item1)
	return false
	
func _drop_data(_at_positon, data):
	var temp = item
	item = data.item
	data.item = temp
	
	temp = amount
	amount= data.amount
	data.amount = temp

func _get_drag_data(at_position):
	return self 

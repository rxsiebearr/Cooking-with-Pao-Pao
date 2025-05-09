extends CanvasLayer


func _process(delta: float) -> void:
	get_node("Control/TextureRect/MoneyEarned/MoneyEarnedCount").text = "x" +str(Global.money_made)
	get_node("Control/TextureRect/OrdersServed/OrderServedCount").text = "x" +str(Global.orders_served)


func _on_next_day_pressed() -> void:
	Functions.load_screen_to_scene("res://game.tscn")
	Global.money_made = 0 
	Global.orders_served = 0
	

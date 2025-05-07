extends CanvasLayer


func _process(delta: float) -> void:
	get_node("Control/TextureRect/MoneyEarned/MoneyEarnedCount").text = "x" +str(Global.money_made)
	get_node("Control/TextureRect/OrdersServed/OrderServedCount").text = "x" +str(Global.orders_served)

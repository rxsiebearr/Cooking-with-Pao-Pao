extends Control

func _ready() -> void:
	get_node("Ticket/VBoxContainer/OrderAmount").text = "x" +str(Global.orders)

func _process(delta: float) -> void:
	get_node("Ticket/VBoxContainer/OrderAmount").text = "x" +str(Global.orders)

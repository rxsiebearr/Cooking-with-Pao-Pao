extends Node

var money = 0
var orders = 0
var money_made = 0
var orders_served = 0

func _process(_delta: float) -> void:
	if orders < 0:
		orders = 0

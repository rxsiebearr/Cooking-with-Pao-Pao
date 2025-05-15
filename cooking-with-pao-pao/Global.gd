extends Node

var money = 10
var orders = 0
var money_made = 0
var orders_served = 0
var rice_seeds = 0
var rice = 0

func _process(delta: float) -> void:
	if orders < 0:
		orders = 0

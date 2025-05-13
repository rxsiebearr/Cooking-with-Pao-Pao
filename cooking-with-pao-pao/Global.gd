extends Node

var money = 0
var orders = 0
var rice_count = 3

func _process(delta: float) -> void:
	if orders < 0:
		orders = 0
 

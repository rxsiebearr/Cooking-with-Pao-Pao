extends Node

var money = 0
var orders = 1

func _process(delta: float) -> void:
	if orders < 0:
		orders = 0
 

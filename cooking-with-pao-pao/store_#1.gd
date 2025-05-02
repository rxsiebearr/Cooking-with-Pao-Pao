extends Node2D

func _input(event) -> void:
	if event.is_action_pressed("ordertest"):
		Global.orders += 1
	

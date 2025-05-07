extends Node


func _on_timer_timeout() -> void:
	Functions.load_screen_to_scene("res://end_of_day_screen.tscn")

extends Node2D



func _on_yes_button_pressed() -> void:
	get_tree().change_scene_to_file("res://store_#1.tscn")


func _on_no_button_pressed() -> void:
	get_tree().change_scene_to_file("res://game.tscn")

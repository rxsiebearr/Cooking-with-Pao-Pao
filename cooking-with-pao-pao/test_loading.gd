extends Control

func _ready():
	MoneyCount.visible = false

func _on_button_pressed() -> void:
	Functions.load_screen_to_scene("res://character_selection.tscn")

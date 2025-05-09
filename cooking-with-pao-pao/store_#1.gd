extends Node2D

@onready var store: Node2D = $"."
@onready var readycook: CanvasLayer = $CanvasLayer2
@onready var day_timer: Timer = $DayTimer


func _ready() -> void:
	store.visible = false



func _on_yes_button_pressed() -> void:
	readycook.visible = false
	store.visible = true
	day_timer.start()



func _on_no_button_pressed() -> void:
	get_tree().change_scene_to_file("res://game.tscn")


func _on_day_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://end_of_day_screen.tscn")

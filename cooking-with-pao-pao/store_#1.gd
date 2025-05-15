extends Node2D

@onready var store: Node2D = $"."
@onready var readycook: CanvasLayer = $CanvasLayer2
@onready var day_timer: Timer = $DayTimer
@onready var store_dialogue: Control = $CanvasLayer3/StoreDialogue

func _ready() -> void:
	if !GlobalData.store_dialogue_finished:
		store_dialogue.show()
		readycook.hide()
	else:
		readycook.show()
		store.visible = false


func _on_yes_button_pressed() -> void:
	readycook.visible = false
	store.visible = true
	day_timer.start()

func _on_store_dialogue_store_dialogue_done() -> void:
	readycook.show()
	store.visible = false

func _on_no_button_pressed() -> void:
	get_tree().change_scene_to_file("res://game.tscn")


func _on_day_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://end_of_day_screen.tscn")

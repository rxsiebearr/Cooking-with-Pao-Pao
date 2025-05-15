extends Node2D

@onready var store: Node2D = $"."
@onready var readycook: CanvasLayer = $CanvasLayer2
@onready var day_timer: Timer = $DayTimer

var is_timer_active = false

func _ready() -> void:
	store.visible = false


func _process(delta: float) -> void:
	if not is_timer_active:
		get_orders()

func get_orders():
	is_timer_active = true 

	await get_tree().create_timer(randi_range(5, 11)).timeout
	Global.orders += 1
	is_timer_active = false

func _on_yes_button_pressed() -> void:
	readycook.visible = false
	store.visible = true
	day_timer.start()


func _on_no_button_pressed() -> void:
	get_tree().change_scene_to_file("res://game.tscn")


func _on_day_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://end_of_day_screen.tscn")

extends CanvasLayer
@onready var panel: Panel = $Panel
@onready var shop: CanvasLayer = $"."

func _process(delta: float) -> void:
	get_node("Label").text = "x" + str(Global.money)


func _on_close_pressed() -> void:
	get_tree().change_scene_to_file("res://game.tscn")

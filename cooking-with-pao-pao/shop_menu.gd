extends CanvasLayer
@onready var panel: Panel = $Panel
@onready var shop: CanvasLayer = $"."

func _on_close_pressed() -> void:
	get_tree().paused = false
	shop.visible = false

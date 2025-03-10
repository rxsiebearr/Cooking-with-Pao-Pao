extends CanvasLayer


func _on_close_pressed() -> void:
	get_node("AnimationPlayer").play("TransOut")
	get_tree().paused = false

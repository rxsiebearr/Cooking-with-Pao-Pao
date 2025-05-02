extends Control

func _process(delta: float) -> void:
	get_node("Label").text = "x" +str(Global.money)

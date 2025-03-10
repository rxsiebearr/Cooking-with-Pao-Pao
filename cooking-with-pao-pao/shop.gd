extends Area2D

var is_Player_near := false

func _ready() -> void:
	body_entered.connect(func (body: Node) -> void:
		is_Player_near = true
	)
	body_exited.connect(func (body: Node) -> void:
		is_Player_near = false
	)


#func _unhandled_input(event: InputEvent) -> void:
#	if is_Player_near and event.is_action_pressed("interact"):
#		get_node("Shop_Menu/AnimationPlayer").play("TransIn")


func _on_body_entered(body: Node2D) -> void:
	get_node("Shop_Menu/AnimationPlayer").play("TransIn")

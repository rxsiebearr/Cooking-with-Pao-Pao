extends Area2D

@onready var shop_menu: CanvasLayer = $Shop_Menu
var is_player_near := false

func _ready() -> void:
	body_entered.connect(func (body: Node) -> void:
		is_player_near = true
	)
	body_exited.connect(func (body: Node) -> void:
		is_player_near = false
	)

func _input(event) -> void:
	if is_player_near and event.is_action_pressed("interact"):
		get_tree().paused = true
		shop_menu.visible = true
		

extends Node2D

var enter: bool = false
var parameter: Dictionary

func _ready():
	var playerCharPath = GlobalData.playerCharPath
	var playerNode = load(playerCharPath).instantiate()
	add_child(playerNode)
	playerNode.global_position = $SpawnPoint.global_position
	
func _process(delta: float) -> void:
	if enter and Input.is_action_just_pressed("interact"):
		get_tree().change_scene_to_file("res://store_#1.tscn")
		
func _on_enter_store_body_entered(body: Node2D) -> void:
	if body is Player:
		enter = true

func _on_enter_store_body_exited(body: Node2D) -> void:
	if body is Player:
		enter = false

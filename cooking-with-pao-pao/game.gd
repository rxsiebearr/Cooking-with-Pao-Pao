extends Node2D

func _ready():
	var playerCharPath = GlobalData.playerCharPath
	var playerNode = load(playerCharPath).insantiate()
	add_child(playerNode)
	#playerNode.global_position = $SpawnPoint.global_position

extends SubViewport

@onready var camera_2d: Camera2D = $Camera2D

func _physics_process(_delta):
	var player = get_node_or_null("root/Game/BearBear")  # Search for the player node in the scene
	if player:
		camera_2d.position = player.position

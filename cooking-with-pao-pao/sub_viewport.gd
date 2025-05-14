extends SubViewport

@onready var camera_2d = $Camera2D

func _physics_process(_delta):
	if GlobalData.player_instantiated:
		camera_2d.position = GlobalData.player_position
		print(camera_2d.position)

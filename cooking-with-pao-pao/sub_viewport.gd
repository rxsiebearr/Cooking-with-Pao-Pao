extends SubViewport

@onready var camera_2d = $Camera2D
@onready var sprite_2d: Sprite2D = $"../Sprite2D"

func _physics_process(_delta):
	if GlobalData.player_instantiated:
		camera_2d.global_position = GlobalData.player_position
		print("camera:")
		print(camera_2d.global_position)
	if camera_2d.global_position.y >= 2188.074:
		sprite_2d.position.y = 144.0
	else: 
		sprite_2d.position.y = 72.0

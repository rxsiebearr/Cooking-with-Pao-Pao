extends Node2D


func _on_video_stream_player_finished():
	Functions.load_screen_to_scene("res://starting_menu.tscn")

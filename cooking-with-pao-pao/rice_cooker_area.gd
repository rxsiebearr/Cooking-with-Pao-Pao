extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func rice_open():
	animation_player.play("rice_open")

func rice_closed():
	animation_player.play("rice_closed")
	
func rice_rice():
	animation_player.play("rice_rice")

func rice_water():
	animation_player.play("rice_water")

func rice_cooked():
	animation_player.play("rice_cooked")

func rice_burnt():
	animation_player.play("rice_burnt")
	
func _on_timer_bar_is_cooked() -> void:
	rice_cooked()

func _on_timer_bar_is_burnt() -> void:
	rice_burnt()

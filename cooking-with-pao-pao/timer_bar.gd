extends Line2D

signal is_cooked
signal is_burnt

@onready var cook_timer: Timer = %CookTimer
@onready var burnt_timer: Timer = %BurntTimer
@onready var audio_stream_player_2d = $"../AudioStreamPlayer2D"

var duration := 5.0
var update_interval := 0.1
var max_length := 100
var step := 0.0

func _ready() -> void:
	points = [Vector2(0,0), Vector2(0,0)]
	step = max_length/ (duration/update_interval)
	cook_timer.wait_time = update_interval

func _increase():
	points[1].x += step
	
func _is_cooked():
	return points[1].x >= max_length
	
func _on_timer_timeout() -> void:
	_increase()
	
	if _is_cooked(): 
		points = [Vector2(0,0), Vector2(0,0)]
		emit_signal("is_cooked")
		cook_timer.stop() 
		audio_stream_player_2d.play()
		burnt_timer.start()

func _on_burnt_timer_timeout() -> void:
	emit_signal("is_burnt")
	Global.money -= 1

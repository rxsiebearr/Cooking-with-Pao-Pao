extends Line2D

signal is_cooked

@onready var timer: Timer = %Timer

var duration := 5.0
var update_interval := 0.1
var max_length := 100
var step := 0.0

func _ready() -> void:
	points = [Vector2(0,0), Vector2(0,0)]
	step = max_length/ (duration/update_interval)
	timer.wait_time = update_interval

func _increase():
	points[1].x += step
	
func _is_cooked():
	return points[1].x >= max_length
	
func _on_timer_timeout() -> void:
	_increase()
	
	if _is_cooked(): 
		emit_signal("is_cooked")
		timer.stop() 
		
		
		
	

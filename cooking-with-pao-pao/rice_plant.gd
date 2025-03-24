extends Node2D

var state = "No Rice"
var Player_In_Area = false
var Rice = preload("res://rice_collectable.tscn")

func _ready() -> void:
	if state == "No Rice":
		$GrowthTimer.start()
func _process(delta: float):
	if state == "No Rice":
		$AnimatedSprite2D.play("No Rice")
	if state == "Rice":
		$AnimatedSprite2D.play("Rice")
		if Player_In_Area:
			if Input.is_action_just_pressed("Interact"):
				state = "No Rice"
				drop_rice()
		


func _on_pickabe_area_body_entered(body: Node2D) -> void:
	if body.has_method("PT"):
		Player_In_Area = true
func _on_pickabe_area_body_exited(body: Node2D) -> void:
	if body.has_method("PT"):
		Player_In_Area = false

func _on_growth_timer_timeout() -> void:
	if state == "No Rice" :
		state = "Rice"
	
func drop_rice():
	var Rice_instance = Rice.instantiate()
	Rice_instance.global_position = $Marker2D.global_position
	get_parent().add_child((Rice_instance))
	
	await get_tree().create_timer(5).timeout
	$GrowthTimer.start()

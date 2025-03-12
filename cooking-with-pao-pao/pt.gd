extends CharacterBody2D

const drag_factor = 10.0
const speed = 300.0
const JUMP_VELOCITY = -400.0
@export var inv: Inventory

func _physics_process(delta: float) -> void:
	var move_direction := Input.get_vector("ui_down", "ui_up", "ui_right", "ui_left")
	var desired_velocity:= speed * move_direction
	var steering := desired_velocity - velocity
	velocity += steering * drag_factor * delta
	move_and_slide()

class_name Anton extends CharacterBody2D

@export var speed := 500
@export var drag_factor := 10.0
@export var max_health := 15
@onready var collision_shape_2d: CollisionShape2D = %CollisionShape2D

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var desired_velocity := speed * direction
	var steering := desired_velocity - velocity
	velocity += steering * drag_factor * delta
	move_and_slide()

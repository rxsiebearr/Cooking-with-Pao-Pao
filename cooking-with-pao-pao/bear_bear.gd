extends CharacterBody2D
@export var inv: Inventory
@export var speed := 500
@export var drag_factor := 10.0
@export var max_health := 15
@onready var collision_shape_2d: CollisionShape2D = %CollisionShape2D

@onready var item_drop = load("res://item_drop.tscn")
@onready var character_sprite: Sprite2D = $CharacterSprite
@onready var item_sprite: Sprite2D = $ItemSprite


var carrying_item: bool = false
var drop_pos: Vector2
var items_in_range: Array = []

func _ready():
	item_sprite.hide()
	
func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var desired_velocity := speed * direction
	var steering := desired_velocity - velocity
	velocity += steering * drag_factor * delta
	move_and_slide()
	
	if direction.x > 0:
		character_sprite.flip_h = false
		item_sprite.flip_h = false
		item_sprite.position.x = 90
		drop_pos = Vector2(12, 13)
	elif direction.x < 0:
		character_sprite.flip_h = true
		item_sprite.flip_h = true
		item_sprite.position.x = -87
		drop_pos = Vector2(-12, 13)
		
func pickup_item(item: Area2D):
	item.queue_free()
	carrying_item = true
	item_sprite.show()

func drop_item():
	item_sprite.hide()
	var item = item_drop.instantiate()
	item.position = position + drop_pos
	get_parent().add_child(item)
	carrying_item = false

#func _on_pickup_area_area_entered(area: Area2D) -> void:
#	if area.is_in_group("item_drop"):
#		items_in_range.append(area)

#func _on_pickup_area_area_exited(area: Area2D) -> void:
#	if area.is_in_group("item_drop"):
#		items_in_range.erase(area)
		
func _input(event):
	if event.is_action_pressed("ui_accept"):
		if carrying_item:
			drop_item()
		else:
			if !items_in_range.is_empty():
				pickup_item(items_in_range.pick_random())

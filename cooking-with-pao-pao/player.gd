extends CharacterBody2D
class_name Player

@export var speed := 500
@export var drag_factor := 10.0
@export var max_health := 15
@onready var collision_shape_2d: CollisionShape2D = %CollisionShape2D
@onready var item_drop = load("res://item_drop.tscn")
@onready var character_sprite: Sprite2D = $CharacterSprite
@onready var item_sprite: Sprite2D = $ItemSprite
@onready var rice_cooker: Sprite2D = $"../RiceCookerArea/RiceCooker"
@onready var rice_cooker_area: Area2D = $"../RiceCookerArea"
@onready var cook_timer: Timer = %CookTimer
@onready var burnt_timer: Timer = %BurntTimer

var enter: bool = false
var done: bool = false
var rice_in_cooker: bool = false
var carrying_item: bool = false
var drop_pos: Vector2
var items_in_range: Array = []
var held_item_name: String = ""

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
	carrying_item = true
	if (item is pickable_item):
		item_sprite.texture = item.item_texture
		held_item_name = item.item_name
	item.queue_free()
	item_sprite.show()

func drop_item():
	item_sprite.hide()
	var item = item_drop.instantiate()
	item.item_texture = item_sprite.texture
	item.item_name = held_item_name
	item.position = position + drop_pos
	get_parent().add_child(item)
	carrying_item = false

func get_held_item_name() -> String:
	return held_item_name
	
func _on_pickup_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("item_drop"):
		items_in_range.append(area)

func _on_pickup_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("item_drop"):
		items_in_range.erase(area)
		
func _input(event):
	if event.is_action_pressed("ui_accept"):
		if carrying_item:
			drop_item()
		else:
			if !items_in_range.is_empty():
				pickup_item(items_in_range.pick_random())
	if event.is_action_pressed("interact"):
		if carrying_item && held_item_name == "RiceBowl" && rice_in_cooker && cook_timer.is_stopped():
				rice_in_cooker = false
				item_sprite.texture = load("res://rice_bowl_filled.png")
				held_item_name = "CookedRice"
				
		elif enter && carrying_item && held_item_name == "Rice":
			rice_cooker.texture = rice_cooker_area.rice_rice()
			rice_in_cooker = true
			item_sprite.hide()
			carrying_item = false
			cook_timer.start()
		
		if event.is_action_pressed("interact"):
			if carrying_item && held_item_name == "CookedRice" && done:
				Global.money += 1
				Global.orders -= 1
				held_item_name = "RiceBowl"
				item_sprite.texture = load("res://rice_bowl-removebg-preview.png")
	


func _on_rice_cooker_area_body_entered(body: Node2D) -> void:
	if body is Player:
		enter = true
		if !rice_in_cooker:
			rice_cooker.texture = rice_cooker_area.rice_open()
		

func _on_rice_cooker_area_body_exited(body: Node2D) -> void:
	if body is Player:
		enter = false
		if !rice_in_cooker:
			rice_cooker.texture = rice_cooker_area.rice_closed()
			

func _on_turn_in_body_entered(body: Node2D) -> void:
	if body is Player:
		done = true

func _on_turn_in_body_exited(body: Node2D) -> void:
	if body is Player:
			done = false

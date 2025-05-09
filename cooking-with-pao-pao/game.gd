extends Node2D

var enter: bool = false
var parameter: Dictionary
var playerNode

@onready var ground: TileMapLayer = $FarmingLand
@onready var crop_layer: TileMapLayer = $Crops


var water_level: Dictionary
var crop: Dictionary
var crop_count = 0

@export var block : Dictionary [String, BlockData]

var currently_equipped : String = "rice"



func _physics_process(_delta):
	for pos in water_level:
		water_level[pos] -= _delta
		if water_level[pos] <= 0:
			water_level.erase(pos)
			drying_tile(pos)
	
	for pos in crop:
		if water_level.has(pos):
			crop[pos]["duration"] += _delta
			
			var duration = crop[pos]["duration"]
			var crop_name = crop[pos]["name"]
			
			if duration >= block[crop_name].duration:
				set_tile(crop_name, pos, crop_layer, block[crop_name].atlas_coords.size() -1)
				crop[pos]["duration"] = -INF
			elif duration > 0:
				var index = block[crop_name].growth_index(duration)
				set_tile(crop_name, pos, crop_layer, index)
	


func _input(event):
	if event is InputEventMouseButton and event.pressed:
		var tile_pos = get_snapped_position(get_global_mouse_position())
		
		if event.button_index == MOUSE_BUTTON_LEFT:
			var data = ground.get_cell_tile_data(tile_pos)
			var tile_name
			if data:
				tile_name = data.get_custom_data("tile_name")
				print(tile_name)
				watering_tile(tile_name, tile_pos, 3)
				
			harvesting(tile_pos)
				
		if event.button_index == MOUSE_BUTTON_RIGHT and not crop.has(tile_pos):
			var data = ground.get_cell_tile_data(tile_pos)
			if data:
				var tile_name = data.get_custom_data("tile_name")
				if tile_name == "soil":  # or whatever name you've assigned to valid ground
					set_tile(currently_equipped, tile_pos, crop_layer)
					crop[tile_pos] = {
						"name" : currently_equipped, 
						"duration" : 0
					}
					print(crop)


func get_snapped_position(global_pos: Vector2) -> Vector2i:
	var local_pos = ground.to_local(global_pos)
	var tile_pos = ground.local_to_map(local_pos)
	return tile_pos
	

func set_tile(tile_name: String, cell_pos: Vector2i, layer : TileMapLayer, coord: int = 0):
	if block.has(tile_name):
		layer.set_cell(cell_pos, block[tile_name].source_id, block[tile_name].atlas_coords[coord])



func watering_tile(tile_name: String, pos: Vector2i, amount: float = 1.0):
	water_level[pos] = amount
	set_tile(tile_name, pos, ground, 1)
	print(water_level)


func drying_tile(pos):
	var tile_pos = get_snapped_position(pos)
	var data = ground.get_cell_tile_data(tile_pos)
	var tile_name
	if data: 
		tile_name = data.get_custom_data("tile_name")
		set_tile(tile_name, pos, ground)
	
func harvesting(pos):
	if crop_layer.get_cell_source_id(pos) != -1 and crop.has(pos) and crop[pos]["duration"] < 0:
		crop_layer.erase_cell(pos)
		print(crop[pos]["name"])
		crop_count += 1
		get_node("CanvasLayer/Control/Label").text = "x" + str(crop_count)
		crop.erase(pos)

func _ready():
	var playerCharPath = GlobalData.playerCharPath
	playerNode = load(playerCharPath).instantiate()
	add_child(playerNode)
	playerNode.global_position = $SpawnPoint.global_position
	
	if GlobalData.next_spawn_position != Vector2.ZERO:
		playerNode.global_position = GlobalData.next_spawn_position
	else:
		playerNode.global_position = $SpawnPoint.global_position
	
func _process(delta: float) -> void:
	if enter and Input.is_action_just_pressed("interact"):
		GlobalData.next_spawn_position = playerNode.global_position
		get_tree().change_scene_to_file("res://store_#1.tscn")
		
		
func _on_enter_store_body_entered(body: Node2D) -> void:
	if body is Player:
		enter = true

func _on_enter_store_body_exited(body: Node2D) -> void:
	if body is Player:
		enter = false


		

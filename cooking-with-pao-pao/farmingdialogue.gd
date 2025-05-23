extends Control

@onready var rich_text_label: RichTextLabel = %RichTextLabel
@onready var next_button: Button = %NextButton
@onready var body = %Body
@onready var farm_box = $"../../FarmBox"
@onready var collision_polygon_2d = $"../../FarmBox/CollisionPolygon2D"
@onready var collision_shape_2d = %CollisionShape2D
@onready var shop_line: Line2D = $"../../ShopLine"
@onready var farm_line = $"../../FarmLine"


var current_item_index := 0
var line_shown: bool = false
var entered: bool = true
var shop: bool = false

var expressions := {
	"happy" = preload("res://happy timmy.png"),
	"ble" = preload("res://bletimmy.png"),
	"mad" = preload("res://kindamadtimmy.png"),
	"talking" = preload("res://talking timmy.png")
}

var dialogue_items: Array[Dictionary] = [
	{
		"expression": expressions["happy"],
		"text": "Here is the farm! You can grow crops here to use at your restaurant.",
	},
	
	{
		"expression": expressions["talking"],
		"text": "To [b]plant[/b] a seed, [b]right click[/b] on the farmland.",
	},
	
	{ 
		"expression": expressions["happy"],
		"text": "To [b]water[/b] a plant, [b]left click[/b] on the farmland.",
	},
	
	{
		"expression": expressions["talking"],
		"text": "To [b]harvest[/b] a plant, [b]left click[/b] on the farmland.",
	},
	
	{
		"expression": expressions["mad"],
		"text": "Try to farm a bit, then follow the path to the rice shop.",
	}
]

func _on_farm_box_body_entered(body):
	if body is Player and !GlobalData.farm_dialogue_finished and GlobalData.dialogue_finished and GlobalData.inside_shop_dialogue_finished:
		show()
		show_text()
		get_tree().paused = true
		next_button.pressed.connect(advance)
		collision_shape_2d.set_deferred("disabled", true)
	else:
		hide()
		
		
	
func show_text() -> void:
	var current_item := dialogue_items[current_item_index]
	rich_text_label.text = current_item["text"]
	body.texture = current_item["expression"]
	rich_text_label.visible_ratio = 0.0
	var tween := create_tween()
	var text_appearing_duration := 1.0
	tween.tween_property(rich_text_label, "visible_ratio", 1.0, text_appearing_duration)
	#var sound_max_offset := audio_stream_player.stream.get_length() - text_appearing_duration
	#var sound_start_position := randf() * sound_max_offset
	#audio_stream_player.play(sound_start_position)
	#tween.finished.connect(audio_stream_player.stop)

func advance() -> void:
	current_item_index += 1
	if current_item_index == dialogue_items.size():
		hide()
		get_tree().paused = false
		GlobalData.farm_dialogue_finished = true
		farm_line.hide()
		shop_line.show()
		collision_shape_2d.set_deferred("disabled", false)
	else:
		show_text()
			

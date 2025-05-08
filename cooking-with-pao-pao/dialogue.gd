extends Control

@onready var rich_text_label: RichTextLabel = %RichTextLabel
@onready var next_button: Button = %NextButton
@onready var body = %Body
@onready var line_2d = $"../../Line2D"
@onready var farm_box = $"../../FarmBox"
@onready var collision_polygon_2d = $"../../FarmBox/CollisionPolygon2D"

var current_item_index := 0
var line_shown: bool = false
var entered: bool = true

var expressions := {
	"happy" = preload("res://happy timmy.png"),
	"ble" = preload("res://bletimmy.png"),
	"mad" = preload("res://kindamadtimmy.png"),
	"talking" = preload("res://talking timmy.png")
}
var dialogue_items: Array[Dictionary] = [
	{
		"expression": expressions["happy"],
		"text": "Welcome to Pao Pao Land! Let me show you around."
	},
	
	{
		"expression": expressions["talking"],
		"text" : 'To move, use "[b]W, A, S, D"[/b].',
	},
	
	{
		"expression": expressions["mad"],
		"text": "Let's go to the farm. Follow the dotted line.",
	}
]

var extra_dialogue_items: Array[Dictionary] = [
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
		"text": "Try to farm a bit, then follow the path to your Rice Shop.",
	}
]
func _ready() -> void:
	show_text()
	get_tree().paused = true
	next_button.pressed.connect(advance)
	
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
	else:
		show_text()
		if not line_shown:
			line_2d.show()
			line_shown = true

func _on_farm_box_body_entered(body):
	if body is Player and entered:
		line_2d.hide()
		dialogue_items += extra_dialogue_items
		show()
		get_tree().paused = true
		show_text()
		entered = false

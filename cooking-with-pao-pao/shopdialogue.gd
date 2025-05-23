extends Control

signal store_dialogue_done

@onready var rich_text_label: RichTextLabel = %RichTextLabel
@onready var next_button: Button = %NextButton
@onready var body = %Body

var current_item_index := 0

var expressions := {
	"happy" = preload("res://happy timmy.png"),
	"ble" = preload("res://bletimmy.png"),
	"mad" = preload("res://kindamadtimmy.png"),
	"talking" = preload("res://talking timmy.png")
}
var dialogue_items: Array[Dictionary] = [
	{
		"expression": expressions["happy"],
		"text": "Welcome to Pao Pao 99!"
	},
	{
		"expression": expressions["talking"],
		"text": "To buy something, click the [b]+[/b] sign."
	},
		{
		"expression": expressions["ble"],
		"text": "Buy a few seeds to plant at the farm then click the [b]X[/b] on the top right and go to the farm."
	},
]
func _ready() -> void:
	if !GlobalData.inside_shop_dialogue_finished:
		show_text()
		get_tree().paused = true
		next_button.pressed.connect(advance)
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
		GlobalData.inside_shop_dialogue_finished = true
		GlobalData.show_farm_line = true
	else:
		show_text()
			

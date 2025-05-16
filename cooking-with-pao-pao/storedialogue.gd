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
		"text": "Welcome to your first store here at Pao Pao Land!"
	},
	
	{
		"expression": expressions["talking"],
		"text" : "This is a rice shop, your goal to to cook and sell rice to the Kung Paoians.",
	},
	
	{
		"expression": expressions["mad"],
		"text": "To pickup or drop something, click [b]enter[/b].",
	},
	#{
		#"expression": expressions["happy"],
		#"text": "Walk up to the fridge and click [b]E[/b] to pickup some rice. ",
	#},
	{
		"expression": expressions["talking"],
		"text": "To put the rice into the rice cooker, click [b]E[/b].",
	},
	
	{
		"expression": expressions["happy"],
		"text": "Put your rice into your rice cooker and wait for the timer to finish.",
	},
	
	{ 
		"expression": expressions["talking"],
		"text": "When you hear a [i]DING[/i], your rice is cooked and you need to pickup the rice bowl.",
	},
	
	{
		"expression": expressions["ble"],
		"text": "Click [b]E[/b] near the rice cooker to put the rice in the bowl.",
	},
	
	{
		"expression": expressions["talking"],
		"text": "Next, when you have an order, go to the pickup station and click [b]E[/b] to deliver the food.",
	},
	{
		"expression": expressions["ble"],
		"text": "If you wait too long, your rice will burn. Pick it up ([b]E[/b]) and throw it in the trash can ([b]E[/b]).",
	},
	{
		"expression": expressions["mad"],
		"text": "If you burn your food, you will lose money.",
	},
		{
		"expression": expressions["ble"],
		"text": "Try to cook as much as you can in the day with the rice you have. Good Luck!",
	},
]
func _ready() -> void:
	if !GlobalData.store_dialogue_finished:
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
		GlobalData.store_dialogue_finished = true
		emit_signal("store_dialogue_done")
	else:
		show_text()
			

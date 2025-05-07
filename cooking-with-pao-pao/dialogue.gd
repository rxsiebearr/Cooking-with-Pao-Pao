extends Control

@onready var rich_text_label: RichTextLabel = %RichTextLabel
@onready var next_button: Button = %NextButton

var dialogue_items := [
	"Welcome to Pao Pao Land! Let me show you around.",
	"To move, use [b]W, A, S, D[/b].",
	"Take the bridge and walk up to the farm!",
]

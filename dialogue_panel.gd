extends Panel

@onready var rich_text_label: RichTextLabel = get_node("RichTextLabel")

@export var characters_per_second: int = 12

func _ready() -> void:
	self.hide()

func display_text(new_text: String) -> void:
	rich_text_label.text = new_text
	rich_text_label.visible_ratio = 0
	self.show()
	var total_characters = new_text.length()
	var duration = total_characters / characters_per_second
	var tween = create_tween()
	tween.tween_property(rich_text_label, "visible_ratio", 1.0, duration)

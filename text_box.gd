extends AnimatedSprite2D

@onready var rich_text_label: RichTextLabel = get_node("RichTextLabel")

@export var characters_per_second: int = 12
@export var tutorial: bool = false

func _ready() -> void:
	if tutorial:
		self.play("tutorial")
	else:
		self.play("default")
	self.hide()
	
func display_text(new_text: String) -> void:
	rich_text_label.text = new_text
	rich_text_label.visible_ratio = 0
	self.show()
	rich_text_label.get_v_scroll_bar().visible = false
	var total_characters = new_text.length()
	var duration = total_characters / characters_per_second
	var tween = create_tween()
	tween.tween_property(rich_text_label, "visible_ratio", 1.0, duration)

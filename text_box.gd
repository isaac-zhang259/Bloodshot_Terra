extends AnimatedSprite2D

@onready var rich_text_label: RichTextLabel = get_node("RichTextLabel")

@onready var yes_button: Button = get_node("Yes")
@onready var no_button: Button = get_node("No")

@export var characters_per_second: int = 12
@export var tutorial: bool = false

var answer: bool = false
var gave_answer: bool = false
signal _gave_answer

func _init() -> void:
	Game.text_box = self

func _ready() -> void:
	if tutorial:
		self.play("tutorial")
	else:
		self.play("default")
	self.hide()
	yes_button.hide()
	no_button.hide()
	
func display_text(new_text: String) -> void:
	yes_button.hide()
	no_button.hide()
	rich_text_label.text = new_text
	rich_text_label.visible_ratio = 0
	self.show()
	rich_text_label.get_v_scroll_bar().visible = false
	var total_characters = new_text.length()
	var duration = total_characters / characters_per_second
	var tween = create_tween()
	tween.tween_property(rich_text_label, "visible_ratio", 1.0, duration)
	
func display_question(new_text: String) -> bool:
	gave_answer = false
	display_text(new_text)
	ask_yes_or_no()
	await _gave_answer
	gave_answer = true
	self.hide()
	return answer
	
func ask_yes_or_no() -> void:
	yes_button.show()
	no_button.show()
	
func _on_yes_pressed() -> void:
	answer = true
	_gave_answer.emit()

func _on_no_pressed() -> void:
	answer = false
	_gave_answer.emit()


func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			#if rich_text_label.visible_ratio == 1:
			print("text box clicked")
			self.hide()

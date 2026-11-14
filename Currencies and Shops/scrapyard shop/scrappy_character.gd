extends Node2D

@onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")

var bought_out: bool = false

func _ready() -> void:
	animation_player.play("idle")


func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if not bought_out:
				Game.text_box.display_question("I don't care who you are. Hand me 20 Opuls and I'll hand you some fuel.")
				while not Game.text_box.gave_answer:
					await get_tree().process_frame
				var answer = Game.text_box.answer
				if answer and SavedData.per_run_currency >= 20:
					bought_out = true
					Game.player.hp += 5
					SavedData.per_run_currency -= 20
				else:
					Game.text_box.display_text("Come back later with the Opuls if you want.")
			else:
				Game.text_box.display_text("I'm all out of crystals to sell. Please leave.")

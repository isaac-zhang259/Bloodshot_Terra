extends Node2D

@onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")

func _ready() -> void:
	animation_player.play("idle")


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			SceneTransistor.start_transition_to("res://Currencies and Shops/engineer shop/engineer_shop_menu.tscn")

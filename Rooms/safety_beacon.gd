extends Node2D

	
func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			SavedData.safety_floor = SavedData.num_floor
			SaveFile.save_safe_area()

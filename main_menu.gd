extends Control
	
func _on_start_pressed() -> void:
	if SaveFile.is_tutorial_complete():
		SceneTransistor.start_transition_to("res://pre_game_area.tscn")
	else:
		SceneTransistor.start_transition_to("res://tutorial.tscn")
	
func _on_quit_pressed() -> void:
	get_tree().quit()

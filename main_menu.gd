extends Control
	
func _on_start_pressed() -> void:
	SceneTransistor.start_transition_to("res://game.tscn")
	
func _on_quit_pressed() -> void:
	get_tree().quit()

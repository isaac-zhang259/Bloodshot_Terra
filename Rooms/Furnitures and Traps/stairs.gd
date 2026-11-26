extends Area2D

@onready var collision_shape: CollisionShape2D = get_node("CollisionShape2D")

func _on_body_entered(body: Node2D) -> void:
	collision_shape.set_deferred("disabled", true)
	if SavedData.num_floor == SavedData.max_floors:
		SaveFile.save_currency()
		SavedData.reset_data()
		SaveFile.unsave_safe_area()
		SaveFile.save_chapter_completion(SavedData.current_chapter)
		#SceneTransistor.start_transition_to("res://game.tscn")
		SceneTransistor.start_transition_to("res://pre_game_area.tscn")
	else:
		SceneTransistor.start_transition_to("res://game.tscn")
	

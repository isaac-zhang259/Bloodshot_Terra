extends Area2D

@onready var collision_shape: CollisionShape2D = get_node("CollisionShape2D")

func _on_body_entered(body: Node2D) -> void:
	collision_shape.set_deferred("disabled", true)
	if SavedData.num_floor == 3:
		SceneTransistor.start_transition_to("res://pre_game_area.tscn")
	else:
		SavedData.reset_data()
		SceneTransistor.start_transition_to("res://game.tscn")
	

extends Area2D

@onready var collision_shape: CollisionShape2D = get_node("CollisionShape2D")

func _on_body_entered(body: Node2D) -> void:
	collision_shape.set_deferred("disabled", true)
	SceneTransistor.start_transition_to("res://game.tscn")

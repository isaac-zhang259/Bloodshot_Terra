extends Character
class_name Enemy

@onready var player: CharacterBody2D = get_tree().current_scene.get_node("Player")
@onready var navigation_agent: NavigationAgent2D = get_node("NavigationAgent2D")

func chase() -> void:
	if not navigation_agent.is_target_reached():
		var vector_to_next_point: Vector2 = navigation_agent.get_next_path_position() - global_position
		var distance_to_next_point: float = vector_to_next_point.length()
		mov_direction = vector_to_next_point
		
		if vector_to_next_point.x > 0 and animated_sprite.flip_h:
			animated_sprite.flip_h = false
		elif vector_to_next_point.x < 0 and not animated_sprite.flip_h:
			animated_sprite.flip_h = true

func _on_path_timer_timeout() -> void:
	_get_path_to_player()
	
func _get_path_to_player() -> void:
	navigation_agent.target_position = player.position

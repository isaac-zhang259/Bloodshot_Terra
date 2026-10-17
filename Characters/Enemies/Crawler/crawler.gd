extends Enemy

const MIN_DISTANCE_TO_PLAYER: int = 40

var distance_to_player: float

func _on_path_timer_timeout() -> void:
	if is_instance_valid(player):
		distance_to_player = (player.position - global_position).length()
		if distance_to_player < MIN_DISTANCE_TO_PLAYER:
			_get_path_to_move_away_from_player()
	else:
		path_timer.stop()
		mov_direction = Vector2.ZERO
		
func _get_path_to_move_away_from_player() -> void:
	var dir: Vector2 = (global_position - player.position).normalized()
	navigation_agent.target_position = global_position + dir * 100

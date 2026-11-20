extends Enemy

const MAX_DISTANCE_TO_PLAYER: int = 80
const MIN_DISTANCE_TO_PLAYER: int = 40
var distance_to_player: float

var aggressive: bool = false

func _on_path_timer_timeout() -> void:
	if is_instance_valid(player) and not stunned:
		distance_to_player = (player.position - global_position).length()
		if aggressive:
			_get_path_to_player()
		else:
			_get_path_to_move_away_from_player()
	else:
		path_timer.stop()
		mov_direction = Vector2.ZERO
			
func _get_path_to_move_away_from_player() -> void:
	var dir: Vector2 = (global_position - player.position).normalized()
	navigation_agent.target_position = global_position + dir * 100

func _shoot_crystals() -> void:
	pass

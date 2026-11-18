extends FiniteStateMachine

func _init() -> void:
	_add_state("asleep")
	_add_state("waking")
	_add_state("charging")
	_add_state("crashed")
	_add_state("hurt")
	_add_state("dead")

func _state_logic(_delta: float) -> void:
	if state == states.move:
		parent.chase()
		parent.move()
		
func _get_transition() -> int:
	match state:
		states.asleep:
			if parent.distance_to_player < parent.MIN_DISTANCE_TO_PLAYER:
				return states.waking
		states.waking:
			if not animation_player.is_playing():
				return states.charging
		states.charging:
			if parent.crashed_into_wall:
				return states.crashed
		states.crashed:
			if not parent.crashed_into_wall:
				return states.charging
		states.hurt:
			if not animation_player.is_playing():
				return states.charging
	return -1

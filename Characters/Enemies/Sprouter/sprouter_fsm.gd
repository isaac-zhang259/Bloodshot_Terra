extends FiniteStateMachine

func _init() -> void:
	_add_state("moving")
	_add_state("attacking")
	_add_state("retreating")
	_add_state("hurt")
	_add_state("dead")
	
func _ready() -> void:
	set_state(states.retreating)

func _state_logic(_delta: float) -> void:
	if state == states.moving:
		parent.chase()
		parent.move()
		
func _get_transition() -> int:
	match state:
		states.moving:
			if parent.aggressive:
				if parent.distance_to_player < parent.MIN_DISTANCE_TO_PLAYER:
					return states.attacking
			else:
				if parent.distance_to_player > parent.MAX_DISTANCE_TO_PLAYER:
					return states.attacking
		states.attacking:
			if not animation_player.is_playing():
				return states.retreating
		states.hurt:
			if not animation_player.is_playing():
				return states.retreating
		states.retreating:
			if not animation_player.is_playing():
				return states.moving
	return -1
		
func _enter_state(_previous_state: int, _new_state: int) -> void:
	match _new_state:
		states.attacking:
			animation_player.play("attacking")
		states.retreating:
			animation_player.play("retreating")
			parent.aggressive = !parent.aggressive
		states.hurt:
			animation_player.play("hurt")
		states.dead:
			animation_player.play("dead")

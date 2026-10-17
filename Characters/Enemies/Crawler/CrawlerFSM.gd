extends FiniteStateMachine

func _init() -> void:
	_add_state("asleep")
	_add_state("waking")
	_add_state("move")
	_add_state("hurt")
	_add_state("dead")

func _ready() -> void:
	set_state(states.move)

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
				return states.move
		states.move:
			if parent.distance_to_player > parent.MIN_DISTANCE_TO_PLAYER:
				return states.asleep
		states.hurt:
			if not animation_player.is_playing():
				return states.move
	return -1
	
func _enter_state(_previous_state: int, _new_state: int) -> void:
	match _new_state:
		states.asleep:
			animation_player.play("asleep")
		states.waking:
			animation_player.play("waking")
		states.move:
			animation_player.play("move")
		states.hurt:
			animation_player.play("hurt")
		states.dead:
			animation_player.play("dead")

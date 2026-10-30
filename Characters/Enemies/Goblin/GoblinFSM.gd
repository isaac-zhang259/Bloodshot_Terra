extends FiniteStateMachine

func _init() -> void:
	_add_state("idle")
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
		states.idle:
			if parent.distance_to_player > parent.MAX_DISTANCE_TO_PLAYER or parent.distance_to_player < parent.MIN_DISTANCE_TO_PLAYER:
				return states.move
		states.move:
			if parent.distance_to_player < parent.MAX_DISTANCE_TO_PLAYER and parent.distance_to_player > parent.MIN_DISTANCE_TO_PLAYER:
				return states.idle
		states.hurt:
			if not animation_player.is_playing():
				return states.move
	return -1
	
func _enter_state(_previous_state: int, _new_state: int) -> void:
	match _new_state:
		states.idle:
			if parent.tutorial_enemy:
				animation_player.play("tutorial_idle")
			else:
				animation_player.play("idle")
		states.move:
			if parent.tutorial_enemy:
				animation_player.play("tutorial_move")
			else:
				animation_player.play("move")
		states.hurt:
			if parent.tutorial_enemy:
				animation_player.play("tutorial_hurt")
			else:
				animation_player.play("hurt")
		states.dead:
			if parent.tutorial_enemy:
				animation_player.play("tutorial_dead")
			else:
				animation_player.play("dead")

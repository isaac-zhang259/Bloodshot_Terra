extends FiniteStateMachine

func _init() -> void:
	_add_state("chase")
	_add_state("hurt")
	_add_state("dead")
	
func _ready() -> void:
	set_state(states.chase)
	
func _state_logic(_delta: float) -> void:
	if state == states.chase:
		parent.chase()
		parent.move()
		
func _get_transition() -> int:
	match state:
		states.hurt:
			if not animation_player.is_playing():
				return states.chase
	return -1
	
func _enter_state(_previous_state: int, _new_state: int) -> void:
	match _new_state:
		states.chase:
			if parent.tutorial_enemy:
				animation_player.play("tutorial_fly")
			else:
				animation_player.play("fly")
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

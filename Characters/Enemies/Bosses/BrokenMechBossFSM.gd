extends FiniteStateMachine

var boss = get_parent()
var start_timer: Timer
var choice: int = 0


func _init() -> void:
	print(boss)
	_add_state("asleep")
	_add_state("starting_roar")
	_add_state("attacking")
	_add_state("shielding")
	_add_state("spawning")
	_add_state("hurt")
	_add_state("dead")

func _ready() -> void:
	set_state(states.asleep)
	
func _get_transition() -> int:
	match state:
		states.asleep:
			return states.starting_roar
		states.starting_roar:
			if not animation_player.is_playing():
				return states.attacking
		states.attacking:
			if not animation_player.is_playing():
				return states.shielding
		states.shielding:
			if not animation_player.is_playing():
				return states.spawning
		states.spawning:
			if not animation_player.is_playing():
				return states.attacking
		states.hurt:
			if boss.enraged:
				return states.shielding
			else:
				return states.attacking
	return -1
			
func _enter_state(_previous_state: int, _new_state: int) -> void:
	match _new_state:
		states.asleep:
			animation_player.play("asleep")
		states.starting_roar:
			animation_player.play("starting_roar")
		states.attacking:
			if randi() % 2 == 0:
				if boss.enraged:
					animation_player.play("slash_and_bash")
				else:
					animation_player.play("slash")
			else:
				animation_player.play("head_bomb")
		states.shielding:
			animation_player.play("shielding")
		states.spawning:
			animation_player.play("spawning")
		states.hurt:
			if boss.enraged:
				animation_player.play("hurt")
			else:
				return
		states.dead:
			animation_player.play("dead")

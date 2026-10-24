extends FiniteStateMachine

var boss = get_parent()
var start_timer: Timer
var choice: int = -1


func _init() -> void:
	print(boss)
	_add_state("asleep")
	_add_state("starting_roar")
	_add_state("idle")
	_add_state("attacking")
	_add_state("shielding")
	_add_state("bombing")
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
				return states.idle
		states.idle:
			if not animation_player.is_playing():
				choice += 1
				if choice > 2:
					choice = 0
				match choice:
					0: return states.attacking
					1: return states.shielding
					2: return states.bombing
		states.attacking:
			if not animation_player.is_playing():
				return states.idle
		states.shielding:
			if not animation_player.is_playing():
				return states.idle
		states.bombing:
			if not animation_player.is_playing():
				return states.idle
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
		states.idle:
			animation_player.play("idle")
		states.attacking:
			if boss.enraged:
				animation_player.play("slash_and_bash")
			else:
				animation_player.play("slash")
		states.shielding:
			animation_player.play("shielding")
		states.bombing:
			animation_player.play("bombing")
		states.hurt:
			return
		states.dead:
			animation_player.play("dead")

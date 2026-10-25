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
	_add_state("retaliating")

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
				choice = randi() % 3
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
		states.retaliating:
			if not animation_player.is_playing():
				choice = randi() % 4
				match choice:
					0: return states.attacking
					1: return states.shielding
					2: return states.bombing
					3: return states.idle
		states.hurt:
			return states.retaliating
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
		states.retaliating:
			animation_player.play("retaliate")
		states.hurt:
			return
		states.dead:
			animation_player.play("dead")

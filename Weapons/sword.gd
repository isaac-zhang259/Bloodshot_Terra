extends Weapon

func dash_player() -> void:
	Game.player.dash()

func reset_player() -> void:
	Game.player.reset_values()

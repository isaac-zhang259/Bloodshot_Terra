extends Weapon


func _process(_delta: float) -> void:
	if on_floor and not Game.player.in_combat and SavedData.safety_room > 0:
		player_detector.set_collision_mask_value(2, false)
		if not animation_player.is_playing():
			self.scale.y = 1
			animation_player.play("beacon_animations/beacon")

func activate_floor_save() -> void:
	SavedData.safety_floor = SavedData.num_floor
	SaveFile.save_safe_area()

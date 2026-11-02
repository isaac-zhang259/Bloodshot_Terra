extends Control

func _on_health_pressed() -> void:
	if SavedData.per_save_currency >= 30:
		SavedData.per_save_currency -= 30
		SavedData.health_upgrade += 2
		SaveFile.save_permanent_upgrades()


func _on_speed_pressed() -> void:
	if SavedData.per_save_currency >= 20:
		SavedData.per_save_currency -= 20
		SavedData.speed_upgrade += 10
		SaveFile.save_permanent_upgrades()


func _on_damage_pressed() -> void:
	if SavedData.per_save_currency >= 40:
		SavedData.per_save_currency -= 40
		SavedData.damage_upgrade += 1
		SaveFile.save_permanent_upgrades()


func _on_exit_pressed() -> void:
	SceneTransistor.start_transition_to("res://pre_game_area.tscn")

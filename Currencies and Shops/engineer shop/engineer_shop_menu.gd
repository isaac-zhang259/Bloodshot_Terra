extends Control

func _on_health_pressed() -> void:
	if SavedData.per_save_currency >= 30:
		SavedData.per_save_currency -= 30
		SavedData.health_upgrade += 2


func _on_speed_pressed() -> void:
	if SavedData.per_save_currency >= 20:
		SavedData.per_save_currency -= 20
		SavedData.speed_upgrade += 5


func _on_damage_pressed() -> void:
	if SavedData.per_save_currency >= 40:
		SavedData.per_save_currency -= 40
		SavedData.damage_upgrade += 1


func _on_exit_pressed() -> void:
	SaveFile.save_permanent_upgrades()
	SaveFile.save_currency()
	SavedData.reset_data()
	SavedData.fetch_data()
	SceneTransistor.start_transition_to("res://pre_game_area.tscn")


func _on_swap_pressed() -> void:
	SaveFile.save_permanent_upgrades()
	SaveFile.save_currency()
	SavedData.reset_data()
	SavedData.fetch_data()
	SceneTransistor.start_transition_to("res://Currencies and Shops/engineer shop/tool_shop_menu.tscn")

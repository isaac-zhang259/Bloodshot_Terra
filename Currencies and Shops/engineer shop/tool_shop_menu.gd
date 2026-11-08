extends Control

var purchased_items: Array = []

func _on_crossbow_pressed() -> void:
	var crossbow = PreloadedScenes.crossbow.resource_path
	if SavedData.per_save_currency >= 15 and not purchased_items.has(crossbow):
		SavedData.per_save_currency -= 15
		purchased_items.append(crossbow)

func _on_safety_beacon_pressed() -> void:
	var beacon = PreloadedScenes.safety_beacon.resource_path
	SaveFile.fetch_safe_area()
	if SavedData.per_save_currency >= 50 and not purchased_items.has(beacon) and not SavedData.has_saved:
		SavedData.per_save_currency -= 50
		purchased_items.append(beacon)

func _on_swap_pressed() -> void:
	SaveFile.save_tools(purchased_items)
	SaveFile.save_currency()
	SavedData.reset_data()
	SavedData.fetch_data()
	SceneTransistor.start_transition_to("res://Currencies and Shops/engineer shop/engineer_shop_menu.tscn")

func _on_exit_pressed() -> void:
	SaveFile.save_tools(purchased_items)
	SaveFile.save_currency()
	SavedData.reset_data()
	SavedData.fetch_data()
	SceneTransistor.start_transition_to("res://pre_game_area.tscn")

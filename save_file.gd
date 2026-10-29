extends Node

const SAVE_PATH = "user://game_progression.cfg"

const SECTION_NAME = "Progression"

const KEY_NAME = "tutorial_completed"

func mark_tutorial_completed() -> void:
	var config = ConfigFile.new()
	config.load(SAVE_PATH)
	config.set_value(SECTION_NAME, KEY_NAME, true)
	config.save(SAVE_PATH)
	
func is_tutorial_complete() -> bool:
	var config = ConfigFile.new()
	if config.load(SAVE_PATH) != OK:
		return false
	return config.get_value(SECTION_NAME, KEY_NAME, false)

func reset_tutorial_completed() -> void:
	var config = ConfigFile.new()
	config.load(SAVE_PATH)
	config.set_value(SECTION_NAME, KEY_NAME, false)
	config.save(SAVE_PATH)

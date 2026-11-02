extends Node

const SAVE_PATH = "user://save_file.cfg"

const PROGRESSION_SECTION = "Progression"
const TUTORIAL_KEY = "tutorial_completed"

const CURRENCY_SECTION = "Currency"
const CURRENCY_KEY = "per_save_currency"

const UPGRADE_SECTION = "Upgrades"
const HEALTH_KEY = "health_upgrade"
const SPEED_KEY = "speed_upgrade"
const DAMAGE_KEY = "damage_upgrade"

func mark_tutorial_completed() -> void:
	var config = ConfigFile.new()
	config.load(SAVE_PATH)
	config.set_value(PROGRESSION_SECTION, TUTORIAL_KEY, true)
	config.save(SAVE_PATH)
	
func is_tutorial_complete() -> bool:
	var config = ConfigFile.new()
	if config.load(SAVE_PATH) != OK:
		return false
	return config.get_value(PROGRESSION_SECTION, TUTORIAL_KEY, false)

func reset_tutorial_completed() -> void:
	var config = ConfigFile.new()
	config.load(SAVE_PATH)
	config.set_value(PROGRESSION_SECTION, TUTORIAL_KEY, false)
	config.save(SAVE_PATH)

func save_currency() -> void:
	var config = ConfigFile.new()
	config.load(SAVE_PATH)
	config.set_value(CURRENCY_SECTION, CURRENCY_KEY, SavedData.per_save_currency)
	config.save(SAVE_PATH)

func get_currency() -> int:
	var config = ConfigFile.new()
	config.load(SAVE_PATH)
	if config.load(SAVE_PATH) != OK:
		return 0
	return config.get_value(CURRENCY_SECTION, CURRENCY_KEY, 0)

func save_permanent_upgrades() -> void:
	var config = ConfigFile.new()
	config.load(SAVE_PATH)
	config.set_value(UPGRADE_SECTION, HEALTH_KEY, SavedData.health_upgrade)
	config.set_value(UPGRADE_SECTION, SPEED_KEY, SavedData.speed_upgrade)
	config.set_value(UPGRADE_SECTION, DAMAGE_KEY, SavedData.damage_upgrade)
	config.save(SAVE_PATH)

func fetch_permanent_upgrades() -> void:
	var config = ConfigFile.new()
	config.load(SAVE_PATH)
	if config.load(SAVE_PATH) != OK:
		return
	SavedData.health_upgrade = config.get_value(UPGRADE_SECTION, HEALTH_KEY, 0)
	SavedData.speed_upgrade = config.get_value(UPGRADE_SECTION, SPEED_KEY, 0)
	SavedData.damage_upgrade = config.get_value(UPGRADE_SECTION, DAMAGE_KEY, 0)

extends Node

const SAVE_PATH = "user://save_file.cfg"

const PROGRESSION_SECTION = "Progression"
const TUTORIAL_KEY = "tutorial_completed"
const SAFE_FLOOR_KEY = "safe_floor"
const SAFE_ROOM_KEY = "safe_room"
const HAS_SAVED_KEY = "has_saved"

const CURRENCY_SECTION = "Currency"
const CURRENCY_KEY = "per_save_currency"

const UPGRADE_SECTION = "Upgrades"
const HEALTH_KEY = "health_upgrade"
const SPEED_KEY = "speed_upgrade"
const DAMAGE_KEY = "damage_upgrade"

const TOOL_SECTION = "Tools"
const TOOL_ARRAY_KEY = "tool_array"

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

func save_safe_area() -> void:
	var config = ConfigFile.new()
	config.load(SAVE_PATH)
	config.set_value(PROGRESSION_SECTION, SAFE_FLOOR_KEY, SavedData.safety_floor)
	config.set_value(PROGRESSION_SECTION, SAFE_ROOM_KEY, SavedData.safety_room)
	config.set_value(PROGRESSION_SECTION, HAS_SAVED_KEY, true)
	config.save(SAVE_PATH)

func unsave_safe_area() -> void:
	var config = ConfigFile.new()
	config.load(SAVE_PATH)
	config.set_value(PROGRESSION_SECTION, SAFE_FLOOR_KEY, 0)
	config.set_value(PROGRESSION_SECTION, SAFE_ROOM_KEY, 0)
	config.set_value(PROGRESSION_SECTION, HAS_SAVED_KEY, false)
	config.save(SAVE_PATH)

func fetch_safe_area() -> void:
	var config = ConfigFile.new()
	config.load(SAVE_PATH)
	if config.load(SAVE_PATH) != OK:
		return
	SavedData.safety_floor = config.get_value(PROGRESSION_SECTION, SAFE_FLOOR_KEY, 0)
	SavedData.safety_room = config.get_value(PROGRESSION_SECTION, SAFE_ROOM_KEY, 0)
	SavedData.has_saved = config.get_value(PROGRESSION_SECTION, HAS_SAVED_KEY, false)
	#if SavedData.num_floor < SavedData.safety_floor:
	SavedData.num_floor = SavedData.safety_floor - 1

func save_tools(tool_array: Array) -> void:
	var config = ConfigFile.new()
	config.load(SAVE_PATH)
	config.set_value(TOOL_SECTION, TOOL_ARRAY_KEY, tool_array)
	config.save(SAVE_PATH)

func fetch_tools() -> void:
	var config = ConfigFile.new()
	config.load(SAVE_PATH)
	if config.load(SAVE_PATH) != OK:
		return
	var tool_array = config.get_value(TOOL_SECTION, TOOL_ARRAY_KEY, [])
	for weapon_path in tool_array:
		print("weapon should be spawned in")
		var weapon_scene = load(weapon_path)
		var real_weapon = weapon_scene.instantiate()
		get_tree().current_scene.add_child.call_deferred(real_weapon)
		real_weapon.on_floor = true
		real_weapon.name = real_weapon.name.to_lower()
		real_weapon.global_position = Game.player.global_position

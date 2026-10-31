extends Node

var doing_tutorial: bool = false
var in_boss_fight: bool = false

var num_floor: int = 0

var max_hp: int = 16
var hp: int = 8
var weapons: Array = []
var equipped_weapon_index: int = 0

var per_run_currency: int = 0
var per_save_currency: int = 0

func reset_data() -> void:
	num_floor = 0
	hp = 8
	weapons = []
	equipped_weapon_index = 0
	per_run_currency = 0
	
func fetch_data() -> void:
	per_save_currency = SaveFile.get_currency()
	#add any new fetching things here, like upgrades and stuff

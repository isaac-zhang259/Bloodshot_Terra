extends Node

var doing_tutorial: bool = false

var num_floor: int = 0

var max_hp: int = 16
var hp: int = 8
var weapons: Array = []
var equipped_weapon_index: int = 0

func reset_data() -> void:
	num_floor = 0
	hp = 8
	weapons = []
	equipped_weapon_index = 0

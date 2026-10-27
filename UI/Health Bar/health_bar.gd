extends Node2D
const bar_segment: PackedScene = preload("res://UI/Health Bar/health_bar_segment.tscn")
var player: CharacterBody2D = null
var max_hp: int = 0
var local_hp: int = 0
var segment_array: Array = []

func _init() -> void:
	global_position.x = 8
	global_position.y = 8
	max_hp = SavedData.max_hp

func _ready() -> void:
	player = Game.player
	local_hp = player.max_hp
	_spawn_segments(max_hp)
	_set_bar(player.hp)
	
func _spawn_segments(num: int) -> void:
	for i in num:
		var new_segment = bar_segment.instantiate()
		if i < num/2:
			new_segment.position = Vector2(i * 13, 0)
			new_segment.z_index = 1
		else:
			new_segment.position = Vector2((i - num/2) * 13 + 2, + 2)
			new_segment.z_index = 0
			new_segment.red = true
		add_child(new_segment)
		segment_array.append(self.get_child(i))
	
func _process(_delta: float) -> void:
	if is_instance_valid(player):
		if local_hp != player.hp:
			_set_bar(player.hp)
		_red_or_blue(max_hp)
		if player.in_game:
			_update_segment(player.hp)
	
func _update_segment(hp: int) -> void:
	if player.hp > 0:
		segment_array[hp - 1].drain_bar()
		local_hp = player.hp
	
func _fill_bar(hp: int) -> void:
	for i in max_hp:
		if i > local_hp and i <= hp:
			segment_array[i].fill_bar()
	local_hp = player.hp
	
func _set_bar(hp: int) -> void:
	for i in max_hp:
		segment_array[i].set_empty()
		if i < hp:
			segment_array[i].set_full()

func _set_blue() -> void:
	for i in max_hp:
		segment_array[i].z_index = 0
		if i <= max_hp / 2 - 1:
			segment_array[i].z_index = 1

func _set_red() -> void:
	for i in max_hp:
		segment_array[i].z_index = 0
		if i > max_hp / 2 - 1:
			segment_array[i].z_index = 1

func _red_or_blue(num: int) -> void:
	_set_blue()
	if player.hp <= num / 2:
		_set_blue()
		if player.red:
			player.red = false
			player.reset_values()
	else:
		_set_red()
		if not player.red:
			player.red = true
			player.reset_values()

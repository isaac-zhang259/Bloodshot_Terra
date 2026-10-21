extends Node2D
const bar_segment: PackedScene = preload("res://UI/Health Bar/health_bar_segment.tscn")
var player: CharacterBody2D = null
var max_hp: int = 0
var local_hp: int = 0
var segment_array: Array = []

func _init() -> void:
	global_position.x = 16
	global_position.y = 16
	max_hp = SavedData.max_hp

func _ready() -> void:
	player = Game.player
	local_hp = player.max_hp
	_spawn_segments(max_hp)
	_set_bar(player.hp)
	
func _spawn_segments(num: int) -> void:
	for i in num:
		var new_segment = bar_segment.instantiate()
		new_segment.position = Vector2(i * 8,0)
		add_child(new_segment)
		segment_array.append(self.get_child(i))
	
func _process(_delta: float) -> void:
	if local_hp != player.hp:
		_set_bar(player.hp)
	_update_segment(player.hp)
	
func _update_segment(hp: int) -> void:
	segment_array[hp - 1].drain_bar()
	local_hp = player.hp
	
func _set_bar(hp: int) -> void:
	for i in max_hp:
		segment_array[i].set_empty()
		if i < hp:
			segment_array[i].set_full()

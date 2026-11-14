extends Node2D

const SPAWN_ROOMS: Array = [preload("res://Rooms/spawn_room_0.tscn"), preload("res://Rooms/spawn_room_1.tscn")]
const INTERMEDIATE_ROOMS: Array = [preload("res://Rooms/room_0.tscn"), preload("res://Rooms/room_1.tscn"), preload("res://Rooms/room_2.tscn"), preload("res://Rooms/room_3.tscn"), preload("res://Rooms/room_4.tscn")]
const SPECIAL_ROOMS: Array = [preload("res://Rooms/special_room_0.tscn"), preload("res://Rooms/special_room_1.tscn")]
const END_ROOMS: Array = [preload("res://Rooms/end_room_0.tscn"), preload("res://Rooms/end_room_1.tscn")]
const MECH_BOSS_SCENE: PackedScene = preload("res://Rooms/mech_boss_room.tscn")
const TEMP_CAMP_ROOM: PackedScene = preload("res://Rooms/temp_camp_room.tscn")
const SIDE_ROOMS_RIGHT: Array = [preload("res://Rooms/side_test_room_0.tscn"), preload("res://Rooms/side_test_room_1.tscn")]
const SIDE_ROOMS_LEFT: Array = [preload("res://Rooms/side_test_room_2.tscn")]

const TILE_SIZE: int = 16
const FLOOR_TILE_INDEX = Vector2i(0, 0)
const RIGHT_WALL_TILE_INDEX = Vector2i(2, 6)
const LEFT_WALL_TILE_INDEX = Vector2i(3, 6)

@export var num_levels: int = 5

@onready var player: CharacterBody2D = get_parent().get_node("Player")

func _ready() -> void:
	SavedData.num_floor += 1
	if SavedData.num_floor == 3:
		num_levels = 3
	if SavedData.num_floor == SavedData.safety_floor and SavedData.has_saved:
		num_levels -= SavedData.safety_room
	_spawn_rooms()
	
func _spawn_rooms() -> void:
	var previous_room: Node2D
	var special_room_spawned: bool = false
	for i in num_levels:
		var room: Node2D
		if i == 0:
			if SavedData.num_floor == SavedData.safety_floor and SavedData.has_saved:
				#spawn in the scientist temporary camp
				room = TEMP_CAMP_ROOM.instantiate()
				player.position = room.get_node("PlayerSpawnPos").position
			else:
				room = SPAWN_ROOMS[randi() % SPAWN_ROOMS.size()].instantiate()
				player.position = room.get_node("PlayerSpawnPos").position
		else: 
			if i == num_levels - 1:
				room = END_ROOMS[randi() % END_ROOMS.size()].instantiate()
			else:
				if SavedData.num_floor == 3:
					room = MECH_BOSS_SCENE.instantiate()
				else:
					if (randi() % 3 == 0 and not special_room_spawned) or (i == num_levels - 2 and not special_room_spawned):
					#if not special_room_spawned:
						room = SPECIAL_ROOMS[randi() % SPECIAL_ROOMS.size()].instantiate()
						special_room_spawned = true
					else:
						#room = INTERMEDIATE_ROOMS[randi() % INTERMEDIATE_ROOMS.size()].instantiate()
						room = INTERMEDIATE_ROOMS[INTERMEDIATE_ROOMS.size() - 1].instantiate()
			var previous_room_door: StaticBody2D = previous_room.get_node("Doors/Door")
						
			var room_tilemap: TileMap = room.get_node("TileMap")
			room.position = previous_room_door.global_position + Vector2.UP * (room_tilemap.get_used_rect().size.y) * TILE_SIZE + Vector2.LEFT * room_tilemap.local_to_map(room.get_node("Entrance/Marker2D2").position).x * TILE_SIZE
			if room.name == "SpecialRoom0":
				room.position += Vector2.DOWN * 7 * TILE_SIZE
			if room.name == "EndRoom0":
				room.position += Vector2.UP * 7 * TILE_SIZE
			if room.name == "EndRoom1":
				room.position += Vector2.UP * 7 * TILE_SIZE
			if room.name == "Room4":
				room.position += Vector2.UP * 5 * TILE_SIZE
			room.room_number = i
		add_child(room)
		previous_room = room
		if room.open_side_right:
			var side_room: Node2D = SIDE_ROOMS_RIGHT[randi() % SIDE_ROOMS_RIGHT.size()].instantiate()
			var side_room_tilemap: TileMap = side_room.get_node("TileMap")
			var room_side_exit: Marker2D = room.get_node("SideEntrance/Marker2D2")
			var side_room_entrance: Marker2D = side_room.get_node("SideEntrance/Marker2D2")
			side_room.position = room_side_exit.global_position + Vector2.RIGHT * ((room_side_exit.position.x - side_room_entrance.position.x) / 2) + Vector2.UP * (side_room_tilemap.local_to_map(side_room_entrance.position).y + 0.5) * TILE_SIZE
			add_child(side_room)
		if room.open_side_left:
			var side_room: Node2D = SIDE_ROOMS_LEFT[randi() % SIDE_ROOMS_LEFT.size()].instantiate()
			var side_room_tilemap: TileMap = side_room.get_node("TileMap")
			var room_side_exit: Marker2D = room.get_node("SideEntrance/Marker2D2")
			var side_room_entrance: Marker2D = side_room.get_node("SideEntrance/Marker2D2")
			side_room.position = room_side_exit.global_position + Vector2.LEFT * ((side_room_entrance.position.x - room_side_exit.position.x) * 2) + Vector2.UP * (side_room_tilemap.local_to_map(side_room_entrance.position).y + 0.5) * TILE_SIZE
			add_child(side_room)

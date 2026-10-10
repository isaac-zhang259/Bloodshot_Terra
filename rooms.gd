extends Node2D

const SPAWN_ROOMS: Array = [preload("res://Rooms/spawn_room_0.tscn"), preload("res://Rooms/spawn_room_1.tscn")]
const INTERMEDIATE_ROOMS: Array = [preload("res://Rooms/room_0.tscn"), preload("res://Rooms/room_1.tscn"), preload("res://Rooms/room_2.tscn")]
const END_ROOMS: Array = [preload("res://Rooms/end_room_0.tscn"), preload("res://Rooms/end_room_1.tscn")]

const TILE_SIZE: int = 16
const FLOOR_TILE_INDEX = Vector2i(3, 1)
const RIGHT_WALL_TILE_INDEX = Vector2i(3, 5)
const LEFT_WALL_TILE_INDEX = Vector2i(4, 5)

@export var num_levels: int = 5

@onready var player: CharacterBody2D = get_parent().get_node("Player")

func _ready() -> void:
	_spawn_rooms()
	
func _spawn_rooms() -> void:
	var previous_room: Node2D
	for i in num_levels:
		var room: Node2D
		if i == 0:
			room = SPAWN_ROOMS[randi() % SPAWN_ROOMS.size()].instantiate()
			player.position = room.get_node("PlayerSpawnPos").position
		else: 
			if i == num_levels - 1:
				room = END_ROOMS[randi() % END_ROOMS.size()].instantiate()
			else:
				room = INTERMEDIATE_ROOMS[randi() % INTERMEDIATE_ROOMS.size()].instantiate()
			var previous_room_tilemap: TileMap = previous_room.get_node("TileMap")
			var previous_room_door: StaticBody2D = previous_room.get_node("Doors/Door")
			var exit_tile_pos: Vector2i = previous_room_tilemap.local_to_map(previous_room_door.position) + Vector2i.UP * 2
			
			var corridor_height: int = randi() % 2 + 2
			for y in corridor_height:
				previous_room_tilemap.set_cell(0, exit_tile_pos + Vector2i(-2, -y - 1), 0, LEFT_WALL_TILE_INDEX)
				previous_room_tilemap.set_cell(0, exit_tile_pos + Vector2i(-1, -y - 1), 0, FLOOR_TILE_INDEX)
				previous_room_tilemap.set_cell(0, exit_tile_pos + Vector2i(0, -y - 1), 0, FLOOR_TILE_INDEX)
				previous_room_tilemap.set_cell(0, exit_tile_pos + Vector2i(1, -y - 1), 0, RIGHT_WALL_TILE_INDEX)
			
			var room_tilemap: TileMap = room.get_node("TileMap")
			room.position = previous_room_door.global_position + Vector2.UP * room_tilemap.get_used_rect().size.y * TILE_SIZE + Vector2.UP * (1 + corridor_height) * TILE_SIZE + Vector2.LEFT * room_tilemap.local_to_map(room.get_node("Entrance/Marker2D2").position).x * TILE_SIZE

		add_child(room)
		previous_room = room

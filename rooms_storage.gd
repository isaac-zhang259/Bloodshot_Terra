extends Node

#3 unique spawn rooms per area
const SPAWN_ROOMS_AREA_0: Array = [preload("res://Rooms/Ruins/area_0_spawn_room_0.tscn"), preload("res://Rooms/Ruins/area_0_spawn_room_1.tscn"), preload("res://Rooms/Ruins/area_0_spawn_room_2.tscn")]
const SPAWN_ROOMS_AREA_1: Array = [preload("res://Rooms/Valley/area_1_spawn_room_0.tscn"), preload("res://Rooms/Valley/area_1_spawn_room_1.tscn"), preload("res://Rooms/Valley/area_1_spawn_room_2.tscn")]
const SPAWN_ROOMS_AREA_2: Array = []
const SPAWN_ROOMS_AREAS: Array = [SPAWN_ROOMS_AREA_0, SPAWN_ROOMS_AREA_1, SPAWN_ROOMS_AREA_2]

#6 unique intermediate rooms per area
const INTERMEDIATE_ROOMS_AREA_0: Array = [preload("res://Rooms/Ruins/area_0_room_0.tscn"), preload("res://Rooms/Ruins/area_0_room_1.tscn"), preload("res://Rooms/Ruins/area_0_room_2.tscn"), preload("res://Rooms/Ruins/area_0_room_3.tscn"), preload("res://Rooms/Ruins/area_0_room_4.tscn"), preload("res://Rooms/Ruins/area_0_room_5.tscn")]
const INTERMEDIATE_ROOMS_AREA_1: Array = [preload("res://Rooms/Valley/area_1_room_0.tscn"), preload("res://Rooms/Valley/area_1_room_1.tscn"), preload("res://Rooms/Valley/area_1_room_2.tscn"), preload("res://Rooms/Valley/area_1_room_3.tscn"), preload("res://Rooms/Valley/area_1_room_4.tscn"), preload("res://Rooms/Valley/area_1_room_5.tscn")]
const INTERMEDIATE_ROOMS_AREA_2: Array = []
const INTERMEDIATE_ROOMS_AREAS: Array = [INTERMEDIATE_ROOMS_AREA_0, INTERMEDIATE_ROOMS_AREA_1, INTERMEDIATE_ROOMS_AREA_2]

#2 unique side rooms per side per area
const SIDE_ROOMS_RIGHT_AREA_0: Array = [preload("res://Rooms/Ruins/area_0_right_side_room_0.tscn"), preload("res://Rooms/Ruins/area_0_right_side_room_1.tscn")]
const SIDE_ROOMS_RIGHT_AREA_1: Array = [preload("res://Rooms/Ruins/area_0_right_side_room_0.tscn")]
const SIDE_ROOMS_RIGHT_AREA_2: Array = []
const SIDE_ROOMS_RIGHT_AREAS: Array = [SIDE_ROOMS_RIGHT_AREA_0, SIDE_ROOMS_RIGHT_AREA_1, SIDE_ROOMS_RIGHT_AREA_2]

const SIDE_ROOMS_LEFT_AREA_0: Array = [preload("res://Rooms/Ruins/area_0_left_side_room_0.tscn"), preload("res://Rooms/Ruins/area_0_left_side_room_1.tscn")]
const SIDE_ROOMS_LEFT_AREA_1: Array = [preload("res://Rooms/Ruins/area_0_left_side_room_0.tscn")]
const SIDE_ROOMS_LEFT_AREA_2: Array = []
const SIDE_ROOMS_LEFT_AREAS: Array = [SIDE_ROOMS_LEFT_AREA_0, SIDE_ROOMS_LEFT_AREA_1, SIDE_ROOMS_LEFT_AREA_2]

#4 unique special rooms per area
const SPECIAL_ROOMS_AREA_0: Array = [preload("res://Rooms/Ruins/area_0_special_room_0.tscn"), preload("res://Rooms/Ruins/area_0_special_room_1.tscn"), preload("res://Rooms/Ruins/area_0_special_room_2.tscn"), preload("res://Rooms/Ruins/area_0_special_room_3.tscn")]
const SPECIAL_ROOMS_AREA_1: Array = [preload("res://Rooms/Valley/area_1_special_room_0.tscn"), preload("res://Rooms/Valley/area_1_special_room_1.tscn"), preload("res://Rooms/Valley/area_1_special_room_2.tscn"), preload("res://Rooms/Valley/area_1_special_room_3.tscn")]
const SPECIAL_ROOMS_AREA_2: Array = []
const SPECIAL_ROOMS_AREAS: Array = [SPECIAL_ROOMS_AREA_0, SPECIAL_ROOMS_AREA_1, SPECIAL_ROOMS_AREA_2]

#3 unique end rooms per area
const END_ROOMS_AREA_0: Array = [preload("res://Rooms/Ruins/area_0_end_room_0.tscn"), preload("res://Rooms/Ruins/area_0_end_room_1.tscn"), preload("res://Rooms/Ruins/area_0_end_room_2.tscn")]
const END_ROOMS_AREA_1: Array = [preload("res://Rooms/Valley/area_1_end_room_0.tscn"), preload("res://Rooms/Valley/area_1_end_room_1.tscn"), preload("res://Rooms/Valley/area_1_end_room_2.tscn")]
const END_ROOMS_AREA_2: Array = []
const END_ROOMS_AREAS: Array = [END_ROOMS_AREA_0, END_ROOMS_AREA_1, END_ROOMS_AREA_2]

#1 boss every chapter
const BOSS_ROOMS: Array = []

const TEMP_CAMP_ROOM: PackedScene = preload("res://Rooms/temp_camp_room.tscn")

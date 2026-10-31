extends Node2D
class_name Room

@export var boss_room: bool = false
@export var lab_room: bool = false
@export var tutorial_room: bool = false

const SPAWN_EXPLOSION_SCENE: PackedScene = preload("res://Characters/Enemies/spawn_explosion.tscn")

const ENEMY_SCENES: Dictionary = {
	"FLYING_CREATURE": preload("res://Characters/Enemies/Flying Creature/flying_creature.tscn"),
	"GOBLIN": preload("res://Characters/Enemies/Goblin/goblin.tscn"),
	"CRAWLER": preload("res://Characters/Enemies/Crawler/crawler.tscn"),
	"SLIME_BOSS": preload("res://Characters/Enemies/Bosses/slime_boss.tscn"),
	"MECH_BOSS": preload("res://Characters/Enemies/Bosses/broken_mech_boss.tscn")
}

var num_enemies: int

@onready var tilemap: TileMap = get_node("TileMap2")
@onready var entrance: Node2D = get_node("Entrance")
@onready var door_container: Node2D = get_node("Doors")
@onready var enemy_positions_container: Node2D = get_node("EnemyPositions")
@onready var player_detector: Area2D = get_node("PlayerDetector")

func _ready() -> void:
	if not tutorial_room:
		num_enemies = enemy_positions_container.get_child_count()
	if not lab_room:
		Game.player.in_game = true
	
func _on_enemy_killed() -> void:
	num_enemies -= 1
	if num_enemies == 0:
		if not tutorial_room:
			_open_doors()
	
func _open_doors() -> void:
	for door in door_container.get_children():
		door.open()
		
func _close_entrance() -> void:
	for entry_position in entrance.get_children():
		print(tilemap.local_to_map(entry_position.position))
		tilemap.set_cell(0, tilemap.local_to_map(entry_position.position), 1, Vector2i(1, 8))
		tilemap.set_cell(0, tilemap.local_to_map(entry_position.position) + Vector2i.DOWN, 1, Vector2i(1, 4))
		
func _spawn_enemies() -> void:
	for enemy_position in enemy_positions_container.get_children():
		var enemy: CharacterBody2D
		if boss_room:
			enemy = ENEMY_SCENES.MECH_BOSS.instantiate()
			SavedData.in_boss_fight = true
		else:
			var random = randi() % 3
			match random:
				0: enemy = ENEMY_SCENES.FLYING_CREATURE.instantiate()
				1: enemy = ENEMY_SCENES.GOBLIN.instantiate()
				2: enemy = ENEMY_SCENES.CRAWLER.instantiate()
		
		enemy.position = enemy_position.position
		call_deferred("add_child", enemy)
		
		var spawn_explosion: AnimatedSprite2D = SPAWN_EXPLOSION_SCENE.instantiate()
		spawn_explosion.position = enemy_position.position
		call_deferred("add_child", spawn_explosion)

func _on_player_detector_body_entered(_body: CharacterBody2D) -> void:
	player_detector.queue_free()
	if tutorial_room:
		SceneTransistor.start_transition_to("res://pre_game_area.tscn")
		SavedData.reset_data()
		SavedData.doing_tutorial = false
	elif num_enemies > 0:
		_close_entrance()
		_spawn_enemies()
	elif lab_room:
		SceneTransistor.start_transition_to("res://game.tscn")
	else:
		_close_entrance()
		_open_doors()

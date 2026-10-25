extends Enemy

@onready var collision_hitbox: Area2D = get_node("CollisionHitbox")
@onready var swing_hitbox: Area2D = get_node("AnimatedSprite2D/SwingHitbox")
@onready var shield_hitbox: Area2D = get_node("AnimatedSprite2D/ShieldHitbox")

const floater_scene: PackedScene = preload("res://Characters/Enemies/Flying Creature/flying_creature.tscn")
const head_bomb_scene: PackedScene = preload("res://Characters/Enemies/Bosses/head_bomb.tscn")

@export var enraged: bool = false
@export var dead: bool = false

var room

func _init() -> void:
	Game.boss = self

func _ready() -> void:
	room = self.get_parent()

func _process(_delta: float) -> void:
	collision_hitbox.knockback_direction = (player.position - global_position).normalized()
	swing_hitbox.knockback_direction = (player.position - global_position).normalized()
	shield_hitbox.knockback_direction = (player.position - global_position).normalized()
	_check_enraged()

func _check_enraged() -> void:
	if hp <= 10:
		enraged = true
	
func _summon_minion() -> void:
	var minion: CharacterBody2D = floater_scene.instantiate()
	minion.position = global_position
	get_tree().current_scene.add_child.call_deferred(minion)
	minion.take_damage.call_deferred(1, (player.position - global_position).normalized(), 800)

func _throw_bomb() -> void:
	var projectile: Area2D = head_bomb_scene.instantiate()
	projectile.launch(global_position, (player.position - global_position).normalized(), 80)
	get_tree().current_scene.add_child.call_deferred(projectile)


func _room_clear() -> void:
	room._open_doors()
	dead = true

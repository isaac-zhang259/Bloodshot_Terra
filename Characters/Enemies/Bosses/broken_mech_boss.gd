extends Enemy

const floater_scene: PackedScene = preload("res://Characters/Enemies/Flying Creature/flying_creature.tscn")
const head_bomb_scene: PackedScene = preload("res://Characters/Enemies/Bosses/head_bomb.tscn")
const knife_scene: PackedScene = preload("res://Characters/Enemies/Goblin/throwable_knife.tscn")

@export var enraged: bool = false

func _ready() -> void:
	_throw_bomb()

func _check_enraged() -> void:
	if hp < 10:
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

func _throw_knife() -> void:
	var projectile: Area2D = knife_scene.instantiate()
	projectile.launch(global_position, (player.position - global_position).normalized(), 100)
	get_tree().current_scene.add_child.call_deferred(projectile)

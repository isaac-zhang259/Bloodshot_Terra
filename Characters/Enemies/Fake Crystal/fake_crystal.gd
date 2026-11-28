extends Node2D

const anima_scene: PackedScene = preload("res://Currencies and Shops/anima_currency.tscn")
const opul_scene: PackedScene = preload("res://Currencies and Shops/opul_currency.tscn")
const floater_scene: PackedScene = preload("res://Characters/Enemies/Flying Creature/flying_creature.tscn")

@onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")

var hp: int = 4
var broken: bool = false
var invincible: bool = false
var room

func _ready() -> void:
	room = self.get_parent()
	print(room)

func take_damage(dam: int, _dir: Vector2, _force: int) -> void:
	if hp > 0:
		hp -= dam
		drop_crystals()
		if hp < 3:
			animation_player.play("break")
	if hp < 1 and not broken:
		broken = true
		animation_player.play("destroy")

func drop_crystals() -> void:
	for i in range(randi_range(1, 2)):
		var opul: Area2D = opul_scene.instantiate()
		opul.position = self.global_position
		opul.launch()
		get_tree().current_scene.add_child.call_deferred(opul)

func shoot_enemies() -> void:
	var minion: CharacterBody2D = floater_scene.instantiate()
	minion.position = global_position + Vector2.UP * randi_range(-5, 5) + Vector2.RIGHT * randi_range(-5, 5)
	get_tree().current_scene.add_child.call_deferred(minion)
	minion.take_damage.call_deferred(0, Vector2.ZERO, 0)
		
func _room_clear() -> void:
	print("opened doors")
	room._open_doors()

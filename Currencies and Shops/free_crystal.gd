extends Node2D

const anima_scene: PackedScene = preload("res://Currencies and Shops/anima_currency.tscn")
const opul_scene: PackedScene = preload("res://Currencies and Shops/opul_currency.tscn")

@onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")

var hp: int = 5
var broken: bool = false

func take_damage(dam: int, _dir: Vector2, _force: int) -> void:
	if hp > 0:
		hp -= dam
		drop_crystals()
		if hp < 4:
			animation_player.play("break")
	if hp < 1 and not broken:
		broken = true
		animation_player.play("destroy")

func drop_crystals() -> void:
	for i in range(randi_range(3, 5)):
		var opul: Area2D = opul_scene.instantiate()
		opul.position = self.global_position
		opul.launch()
		get_tree().current_scene.add_child.call_deferred(opul)

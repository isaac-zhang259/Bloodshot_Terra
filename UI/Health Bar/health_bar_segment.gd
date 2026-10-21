extends Node2D

@onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")

var full: bool = true
var red: bool = false

func drain_bar() -> void:
	if red:
		animation_player.play("red_drain")
	else:
		animation_player.play("blue_drain")
	full = false

func fill_bar() -> void:
	animation_player.play("RESET")
	if red:
		animation_player.play("red_full")
	else:
		animation_player.play("blue_full")
	full = true
	
func set_full() -> void:
	if red:
		animation_player.play("red_set_full")
	else:
		animation_player.play("blue_set_full")
	full = true
	
func set_empty() -> void:
	animation_player.play("RESET")
	full = false
	
func damage_player() -> void:
	Game.player.take_damage(1, Vector2.ZERO, 0)

extends Node2D

@onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")

var full: bool = true

func drain_bar() -> void:
	animation_player.play("blue_drain")
	full = false

func fill_bar() -> void:
	animation_player.play("RESET")
	animation_player.play("blue_fill")
	full = true
	
func set_full() -> void:
	animation_player.play("blue_set_full")
	full = true
	
func set_empty() -> void:
	animation_player.play("RESET")
	full = false
	
func damage_player() -> void:
	Game.player.take_damage(1, Vector2.ZERO, 0)

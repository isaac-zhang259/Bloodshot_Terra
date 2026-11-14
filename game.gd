extends Node2D

var player: CharacterBody2D = null

var text_box: AnimatedSprite2D = null

var boss: CharacterBody2D = null

func _init() -> void:
	randomize()
	

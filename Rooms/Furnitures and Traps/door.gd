extends StaticBody2D

@onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")

@export var opened: bool = true

func _ready() -> void:
	if not opened:
		animation_player.play("reset_closed")
		opened = false

func trigger_change() -> void:
	if opened:
		close()
	else:
		open()

func open() -> void:
	opened = true
	animation_player.play("open")

func close() -> void:
	opened = false
	animation_player.play("close")

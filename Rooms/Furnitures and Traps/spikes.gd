extends Hitbox

@onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")

@export var active: bool = true

func _process(_delta: float) -> void:
	if not animation_player.is_playing():
		if active:
			animation_player.play("pierce")

func _collide(body: Node2D) -> void:
	if not body.flying:
		knockback_direction = (body.global_position - global_position).normalized()
		body.take_damage(damage, knockback_direction, knockback_force)

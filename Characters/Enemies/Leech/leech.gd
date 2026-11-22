extends Enemy

@onready var hitbox: Area2D = get_node("Hitbox")

func _process(_delta: float) -> void:
	hitbox.knockback_direction = velocity.normalized()
	if hp > 1:
		max_speed = 50
	else:
		max_speed = 30

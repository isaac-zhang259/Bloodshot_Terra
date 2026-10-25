extends Hitbox

@onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")

var enemy_exited: bool = false

var direction: Vector2 = Vector2.ZERO
var bomb_speed: int = 0

func launch(initial_position: Vector2, dir: Vector2, speed: int) -> void:
	position = initial_position
	direction = dir
	knockback_direction = dir
	bomb_speed = speed
	
func _physics_process(delta: float) -> void:
	position += direction * bomb_speed * delta

func _on_body_exited(_body: Node2D) -> void:
	if not enemy_exited:
		enemy_exited = true
	set_collision_mask_value(1, true)
	set_collision_mask_value(2, true)

func _explode() -> void:
	bomb_speed = 0
	knockback_direction = (Game.player.position - global_position).normalized()
	animation_player.play("explode")

func _collide(body: Node2D) -> void:
	if enemy_exited:
		if body.has_method("take_damage"):
			body.take_damage(damage, knockback_direction, knockback_force)


func _on_bomb_timer_timeout() -> void:
	_explode()

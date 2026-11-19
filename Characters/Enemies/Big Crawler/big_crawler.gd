extends Enemy

@onready var hitbox: Area2D = get_node("Hitbox")

@onready var stun_timer: Timer = get_node("StunTimer")

const MIN_DISTANCE_TO_PLAYER: int = 40

var distance_to_player: float = 100

var awake: bool = false
var crashed_into_wall: bool = false
var charging: bool = false

func _ready() -> void:
	stunned = true
	var __ = connect("tree_exited", Callable(get_parent(), "_on_enemy_killed"))

func _process(_delta: float) -> void:
	if is_instance_valid(player):
		distance_to_player = (player.position - global_position).length()
		hitbox.knockback_direction = (player.position - global_position).normalized()
	if distance_to_player < MIN_DISTANCE_TO_PLAYER:
		awake = true
		stunned = false
	var collision = get_last_slide_collision()
	if collision:
		crash(collision)

func crash(collision) -> void:
	stunned = true
	crashed_into_wall = true
	var wall_normal = collision.get_normal()
	mov_direction = mov_direction.bounce(wall_normal)
	if animated_sprite.flip_h:
		animated_sprite.flip_h = false
	elif not animated_sprite.flip_h:
		animated_sprite.flip_h = true
	velocity += mov_direction * 80
	stun_timer.start()
	
func _on_stun_timer_timeout() -> void:
	if is_instance_valid(player):
		_get_path_to_player()
	stunned = false
	crashed_into_wall = false

extends Enemy

@onready var hitbox: Area2D = get_node("Hitbox")

@onready var stun_timer: Timer = get_node("StunTimer")

const MIN_DISTANCE_TO_PLAYER: int = 40

var distance_to_player: float

var awake: bool = false
var crashed_into_wall: bool = false
var charging: bool = false

func _ready() -> void:
	stunned = true

func _process(_delta: float) -> void:
	hitbox.knockback_direction = (player.position - global_position).normalized()
	if is_on_wall():
		crash()
	
func _on_path_timer_timeout() -> void:
	if is_instance_valid(player):
		distance_to_player = (player.position - global_position).length()
		if distance_to_player < MIN_DISTANCE_TO_PLAYER and not awake:
			awake = true
			stunned = false
			
			
func crash() -> void:
	stunned = true
	crashed_into_wall = true
	var wall_normal = get_wall_normal()
	mov_direction = mov_direction.bounce(wall_normal)
	stun_timer.start()
	

func _on_stun_timer_timeout() -> void:
	stunned = false
	crashed_into_wall = false

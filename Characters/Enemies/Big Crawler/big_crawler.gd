extends Enemy

@onready var hitbox: Area2D = get_node("Hitbox")

@onready var stun_timer: Timer = get_node("StunTimer")

const MIN_DISTANCE_TO_PLAYER: int = 200

var distance_to_player: float

var awake: bool = false
var crashed_into_wall: bool = false
var charging: bool = false

func _ready() -> void:
	stunned = true

func _process(_delta: float) -> void:
	hitbox.knockback_direction = (player.position - global_position).normalized()
	if distance_to_player < MIN_DISTANCE_TO_PLAYER:
		awake = true
		stunned = false
	if is_on_wall():
		crash()
		
func crash() -> void:
	print("crashed")
	stunned = true
	crashed_into_wall = true
	var wall_normal = get_wall_normal()
	mov_direction = mov_direction.bounce(wall_normal)
	velocity += mov_direction * 30
	stun_timer.start()
	
func _on_stun_timer_timeout() -> void:
	stunned = false
	crashed_into_wall = false
